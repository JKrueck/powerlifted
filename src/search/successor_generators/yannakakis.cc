
#include "yannakakis.h"
#include "../database/hash_join.h"
#include "../database/project.h"
#include "../database/semi_join.h"
#include "../database/table.h"
#include "../task.h"

#include <cassert>
#include <iostream>
#include <queue>
#include <stack>

using namespace std;

/**
 *
 * @attention This code has a lot of duplication from full_reducer_successor_generator.cc
 *
 * @details The only difference between the Yannakakis and the Full reducer
 * successor generators is how the complete join sequence is computed after
 * the full reducer. Here, we find the same order that would be done by
 * Yannakakis' algorithm, based on the join tree.
 *
 * @see full_reducer_successor_generator.cc
 *
 * @param task
 */
YannakakisSuccessorGenerator::YannakakisSuccessorGenerator(const Task &task)
    : GenericJoinSuccessor(task)
{
    /*
     * Apply GYO algorithm for every action schema to check whether it has acyclic precondition/
     *
     * A lot of duplication from Full reducer successor generator.
     */

    size_t number_action_schemas = task.get_number_action_schemas();

    full_reducer_order.resize(number_action_schemas);
    // Join tree order is the order in which the project-join is performed in a join tree.
    // Every entry is a pair of nodes, where the first one is the child of the second.
    // The idea is that we can compute a join tree from the GYO algorithm in a bottom-up
    // style based on the ear removal order. E.g., if we remove E in favor of F, then
    // E is a child of F in the tree.
    join_trees.reserve(number_action_schemas);
    distinguished_variables.resize(number_action_schemas);
    remaining_join.resize(number_action_schemas);
    for (const ActionSchema &action : task.get_action_schemas()) {
        get_distinguished_variables(action);
        JoinTree jt;
        vector<int> hypernodes;
        vector<set<int>> hyperedges;
        vector<int> missing_precond;
        map<int, int> node_index;
        map<int, int> node_counter;
        map<int, int> edge_to_precond;
        map<int, int> precond_to_size;
        create_hypergraph(action,
                          hypernodes,
                          hyperedges,
                          missing_precond,
                          node_index,
                          node_counter,
                          edge_to_precond);

        /*
         * GYO algorithm.
         * We probably should have a better method to order cyclic precond
         */
        bool has_ear = true;
        stack<pair<int, int>> full_reducer_back;
        vector<bool> removed(hyperedges.size(), false);
        while (has_ear) {
            has_ear = false;
            int ear = -1;
            int in_favor = -1;
            for (size_t i = 0; i < hyperedges.size() and !has_ear; ++i) {
                if (removed[i]) {
                    continue;
                }
                for (size_t j = 0; j < hyperedges.size() and !has_ear; ++j) {
                    if (removed[j] or i == j) {
                        continue;
                    }
                    set<int> diff;
                    // Contained only in the first hyperedge, then it is an ear
                    set_difference(hyperedges[i].begin(),
                                   hyperedges[i].end(),
                                   hyperedges[j].begin(),
                                   hyperedges[j].end(),
                                   inserter(diff, diff.end()));
                    has_ear = true;
                    ear = i;
                    in_favor = j;
                    for (int n : diff) {
                        if (node_counter[n] > 1) {
                            has_ear = false;
                            ear = -1;
                            in_favor = -1;
                        }
                    }
                    if (has_ear) {
                        for (int n : hyperedges[ear]) {
                            node_counter[n] = node_counter[n] - 1;
                        }
                    }
                }
                if (has_ear) {
                    assert(ear != -1 and in_favor != -1);
                    removed[ear] = true;
                    full_reducer_order[action.get_index()].emplace_back(edge_to_precond[ear],
                                                                        edge_to_precond[in_favor]);
                    full_reducer_back.emplace(edge_to_precond[in_favor], edge_to_precond[ear]);
                    jt.add_node(edge_to_precond[ear], edge_to_precond[in_favor]);
                }
            }
        }
        hypernodes.clear();
        join_trees.emplace_back(jt);
        while (!full_reducer_back.empty()) {
            pair<int, int> p = full_reducer_back.top();
            full_reducer_order[action.get_index()].push_back(p);
            full_reducer_back.pop();
        }
        // Add all hyperedges that were not removed to the join. If it is acyclic, there is only
        // left.
        for (int k : missing_precond) {
            remaining_join[action.get_index()].push_back(k);
        }
        int not_removed_counter = 0;
        for (auto &&k : removed) {
            if (!k) {
                ++not_removed_counter;
            }
        }
        if (not_removed_counter == 1) {
            /*
             * We need to add the root of every component and join them.
             * But since we considered all components when computing the full reducer,
             * there is only one.
             */
            for (size_t k = 0; k < removed.size(); ++k) {
                if (!removed[k]) {
                    remaining_join[action.get_index()].push_back(edge_to_precond[k]);
                }
            }
        }
        else {
            priority_queue<pair<int, int>> q;
            remaining_join[action.get_index()].clear();
            remaining_join[action.get_index()].reserve(removed.size() + missing_precond.size());
            for (size_t k = 0; k < missing_precond.size(); ++k) {
                // TODO This is really ugly
                q.emplace(action.get_precondition()[k].get_arguments().size(), missing_precond[k]);
            }
            for (size_t k = 0; k < removed.size(); ++k) {
                q.emplace(hyperedges[k].size(), edge_to_precond[k]);
            }
            while (!q.empty()) {
                int p = q.top().second;
                remaining_join[action.get_index()].push_back(p);
                q.pop();
            }
        }
    }
}

void YannakakisSuccessorGenerator::get_distinguished_variables(const ActionSchema &action)
{
    int action_index = action.get_index();
    for (const Atom &eff : action.get_effects()) {
        for (const Argument &arg : eff.get_arguments()) {
            if (!arg.is_constant())
                distinguished_variables[action_index].insert(arg.get_index());
        }
    }

    for (const Atom &atom : action.get_static_precondition()) {
        // TODO: for now, we assume all static preconditions are
        //       (in)equalities. This may change in future
        const std::vector<Argument> &args = atom.get_arguments();
        assert(args.size() == 2);
        if (atom.is_negated()) {
            if (!args[0].is_constant())
                distinguished_variables[action_index].insert(args[0].get_index());
            if (!args[1].is_constant())
                distinguished_variables[action_index].insert(args[1].get_index());
        }
    }
}

/*Table YannakakisSuccessorGenerator::thesis_instantiate(const ActionSchema &action,
                    const DBState &state,const Task &task, Table &thesis_table, std::unordered_set<int> &thesis_matching)
{
    
    auto thesis = state.get_thesis();
    auto diff = thesis.get_diff_at_idx(action.get_index());
    
    unordered_map<int,int> index_table;
    for(int i=0;i<thesis.get_table_copy_at_idx(action.get_index()).tuple_index.size();i++){
        index_table.insert({thesis.get_table_at_idx(action.get_index())->tuple_index.at(i),i});
    }
    

    std::unordered_map<int,bool> has_matches;

    auto effects = action.get_effects();
    for (int i=0;i<effects.size();i++){
        auto args = effects.at(i).get_arguments();
        for(int j=0; j<args.size();j++){
            if( std::find(thesis.get_matches_at_idx(action.get_index())->begin(),
                thesis.get_matches_at_idx(action.get_index())->end(),args.at(j).get_index())!=
                thesis.get_matches_at_idx(action.get_index())->end())
                {
                has_matches.insert({args.at(j).get_index(),true});
            }else{
                has_matches.insert({args.at(j).get_index(),false});
            }
        }
    }




    vector<vector<tuple_t>> remember;
    if(diff->size() > 0){
        for(int i=0;i<diff->size();i++){
            vector<tuple_t> temp;
            std::unordered_map<int,bool> is_inserted;
            for(int j=0;j<diff->at(i).size();j++){
                //if we know that an ground atom has never been used as a match when computing the hash join we can skip looking for it 
                if(!has_matches.at(action.get_effects().at(i).get_arguments().at(j).get_index())){
                    continue;
                }
                for(int k=0;k<thesis.get_table_at_idx(action.get_index())->tuples.size();k++){
                    GroundAtom test = thesis.get_table_at_idx(action.get_index())->tuples.at(k);
                    //if( std::find(test.begin(),test.end(),diff[i].at(j))!= test.end() &&
                      //  is_inserted.count(k)==0){

                        //    temp.push_back(test);
                        //    is_inserted.insert({k,true});
                    //}
                }
            }
            remember.push_back(temp);
        }
    }

    for(int i=0;i<remember.size();i++){
        int predicate = effects.at(i).get_predicate_symbol_idx();
        vector<int> tuple_indices = thesis.get_tuple_indices_at_idx(action.get_index())->at(predicate);
        tuple_t new_table_entry;
        for(int j=0;j<remember.at(i).size();j++){
            new_table_entry.resize(remember.at(i).at(j).size());
            for(int k=0;k<remember.at(i).at(j).size();k++){
                int consider = index_table.at(k);
                auto search = std::find(tuple_indices.begin(),tuple_indices.end(),consider);
                if(search != tuple_indices.end()){
                    new_table_entry.at(k) = diff->at(i).at(search-tuple_indices.begin());
                }else{
                    new_table_entry.at(k) = remember.at(i).at(j).at(k);
                }
            }
            thesis.get_table_at_idx(action.get_index())->tuples.push_back(new_table_entry);

        }
    }

    return thesis.get_table_copy_at_idx(action.get_index());

}*/
void YannakakisSuccessorGenerator::filter_delete( std::vector<std::vector<Table>> &thesis_tables,std::vector<GroundAtom> &diff_delete, int action_id){
    for(long unsigned int i=0; i<thesis_tables.at(action_id).size();i++){
        //cout << "Before del correction: "<< thesis_tables.at(action_id).at(i).tuples.size() << endl;
        for(long unsigned int j=0; j<thesis_tables.at(action_id).at(i).tuples.size();){
            //Take the intersection between the deleted atoms and the tuple; if the result is non-zero than the original tuple delete it
            for(auto diff_it:diff_delete){ 
                GroundAtom result;
                //result.reserve(tuple.size());
                std::set_intersection(diff_it.begin(),diff_it.end(),thesis_tables.at(action_id).at(i).tuples.at(j).begin(),thesis_tables.at(action_id).at(i).tuples.at(j).end(), std::inserter(result,result.begin()));
                if(result.size() > 0){
                    auto pos = thesis_tables.at(action_id).at(i).tuples.erase(thesis_tables.at(action_id).at(i).tuples.begin()+j);
                    j = pos - thesis_tables.at(action_id).at(i).tuples.begin();
                }else{
                    j++;
                }
            } 
        }
        //cout << "After del correction: "<< thesis_tables.at(action_id).at(i).tuples.size() << endl;
    }
}

Table YannakakisSuccessorGenerator::thesis_instantiate2(const ActionSchema &action,const DBState &state,const Task &task, ThesisClass &thesis, std::vector<std::vector<Table>> &thesis_tables)
{
    cout << "used" << endl;
    std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> predicate_to_add_diff;
    std::vector<GroundAtom> diff_delete;
    //Find the add-effect differences between the current state and the state when this action was last used
    for(long unsigned int i=0;i<state.get_relations().size();i++){
        std::unordered_set<GroundAtom,TupleHash> diff_add;
        if(state.get_tuples_of_relation(i).size()!=0){
            std::unordered_set<GroundAtom,TupleHash> new_tuples = state.get_tuples_of_relation(i);
            std::unordered_set<GroundAtom,TupleHash> old_tuples = thesis.get_state().get_tuples_of_relation(i);
            
            if(true){
                //std::set_difference(new_tuples.begin(),new_tuples.end(),old_tuples.begin(),old_tuples.end(),std::inserter(diff,diff.begin()));

                /*
                Okay-ish runtime I guess
                _.count has constant average case complexity and linear worst case
                Worst case -> O(n*m); n size of new_tuples, m size of old_tuples
                */
                for(auto it:new_tuples){
                    if(old_tuples.count(it)==0){
                        diff_add.insert(it);
                    }
                }
                //Quick and dirty way to find deleted atoms -> probably need a smarter method for this ....
                for(auto it:old_tuples){
                    if(new_tuples.count(it)==0){
                        //unorder_set isn´t useful at all with what im trying to do..
                        //convert it to vector for now
                        diff_delete.push_back(it);
                        
                    }
                }
                if(diff_add.size()!=0){
                    predicate_to_add_diff.insert({i,diff_add});
                }


            }
            
        }       
    }
    if(diff_delete.size() != 0) {
        filter_delete(thesis_tables,diff_delete, action.get_index());
    }
    
    
    //Create a new relations vector that only contains the add effect changes
    std::vector<Relation> new_relations;
    new_relations.resize(state.get_relations().size());
    for(long unsigned int i=0;i<state.get_relations().size();i++){
        if(predicate_to_add_diff.count(i)!=0){
            auto tuples = predicate_to_add_diff.at(i);
            new_relations[i] = Relation(i,std::move(tuples));
        }else{
            auto tuples = state.get_tuples_of_relation(i);
            new_relations[i] = Relation(i,std::move(tuples));
        }
    }
    //Save for which tables we need to re compute the hash join
    std::unordered_map<int,bool> compute_hash_join;
    for(long unsigned int i=0;i<new_relations.size();i++){
        if(new_relations.at(i).tuples.size()!= 0){
            compute_hash_join.insert({i,true});
        }else{
            compute_hash_join.insert({i,false});
        }
    }
    std::vector<bool> nullary = state.get_nullary_atoms();
    //Create a modified state with the new relations
    DBState mod_state = DBState(std::move(new_relations), std::move(nullary));

    const auto &actiondata = action_data[action.get_index()];
    vector<Table> tables;
    auto res = parse_precond_into_join_program(actiondata, mod_state, tables);
    if (!res)
        return Table::EMPTY_TABLE();

    assert(!tables.empty());
    assert(tables.size() == actiondata.relevant_precondition_atoms.size());


    const JoinTree &jt = join_trees[action.get_index()];

    std::unordered_map<int,std::vector<int>> thesis_indices;
    int counter = 0;
    for (const auto &j : jt.get_order()) {//compute_hash_join.at(j.first) || compute_hash_join.at(j.second)
        if(compute_hash_join.at(j.first) || compute_hash_join.at(j.second)){

            //thesis_indices.insert({j.first,tables.at(j.first).tuple_index});
            //thesis_indices.insert({j.second,tables.at(j.second).tuple_index});

            unordered_set<int> project_over;
            for (auto x : tables[j.second].tuple_index) {
                project_over.insert(x);
            }
            for (auto x : tables[j.first].tuple_index) {
                if (distinguished_variables[action.get_index()].count(x) > 0) {
                    project_over.insert(x);
                }
            }
            Table &working_table = tables[j.second];
            hash_join(working_table, tables[j.first]);


            // Project must be after removal of inequality constraints, otherwise we might keep only the
            // tuple violating some inequality. Variables in inequalities are also considered
            // distinguished.


            /*for(auto it:thesis.get_current_tables()->at(action.get_index()).at(counter).tuples ){
                for(auto tuple:it){
                    cout << tuple << endl;
                }
            }*/

            //save the result of the hashjoin by appending the new results to the old ones
            for(auto it:working_table.tuples){
                //thesis.get_join_tables()->at(counter).tuples.push_back(it);
                thesis_tables.at(action.get_index()).at(counter).tuples.push_back(it);
            }
            

            filter_static(action, working_table);
            project(working_table, project_over);
            if (working_table.tuples.empty()) {
                return working_table;
            }
            
            //compute_hash_join.insert_or_assign(j.first,true);
            compute_hash_join.insert_or_assign(j.second,true);
        }else{
            //tables[j.second] = thesis.get_join_tables()->at(counter);
            tables[j.second] = thesis_tables.at(action.get_index()).at(counter);
        }
        counter++;
    }

    //Table &working_table = tables[remaining_join[action.get_index()][0]];
    //Table &working_table = thesis.get_join_tables()->back();
    //Table &working_table = thesis_tables.at(action.get_index()).back();
    //add the new instantiations to the old ones
    //working_table.tuples.insert(working_table.tuples.end(),thesis.get_join_tables()->back().tuples.begin(),thesis.get_join_tables()->back().tuples.end());
    
    // For the case where the action schema is cyclic
    Table &working_table = tables[remaining_join[action.get_index()][0]];
    for (size_t i = 1; i < remaining_join[action.get_index()].size(); ++i) {
        hash_join(working_table, tables[remaining_join[action.get_index()][i]]);
        filter_static(action, working_table);
        if (working_table.tuples.empty()) {
            return working_table;
        }
    }

    filter_static(action, working_table);
    
    project(working_table, distinguished_variables[action.get_index()]);
    return working_table;

}

/**
 *
 * Instantiate a given action at a given state using Yannakakis' algorithm.
 *
 *
 * @attention Partially duplicated from full_reducer_successor_generator.cc
 *
 * @details The process here is the same as the full reducer. However, as we
 * process the join tree (instead of a simple join sequence), we need to apply
 * the projection operation as defined by Yannakakis' algorithm. See Ullman's
 * book or Correa et al. ICAPS 2020 for details.
 *
 * @see database/hash_join.h
 * @see database/semi_join.h
 * @see full_reducer_successor_generator.cc
 *
 * @param action Action schema currently being instantiated
 * @param state State used as database
 * @param staticInformation  Static predicates of the task
 * @return
 */
Table YannakakisSuccessorGenerator::instantiate(const ActionSchema &action, const DBState &state,const Task &task, ThesisClass &thesis, std::vector<std::vector<Table>> &thesis_tables)
{

    if (action.is_ground()) {
        throw std::runtime_error("Shouldn't be calling instantiate() on a ground action");
    }



    if(thesis.is_enabled() && thesis_tables.at(action.get_index()).size()!=0){
        Table thesis_return_table = thesis_instantiate2(action,state,task, thesis, thesis_tables);
        return thesis_return_table;
    }else{
        const auto &actiondata = action_data[action.get_index()];

        vector<Table> tables;
        auto res = parse_precond_into_join_program(actiondata, state, tables);
        if (!res)
            return Table::EMPTY_TABLE();

        assert(!tables.empty());
        assert(tables.size() == actiondata.relevant_precondition_atoms.size());

        for (const pair<int, int> &sj : full_reducer_order[action.get_index()]) {
            size_t s = semi_join(tables[sj.second], tables[sj.first]);
            if (s == 0) {
                return Table::EMPTY_TABLE();
            }
        }

        //Save the fully reduced tables of this state
        //thesis.set_initial_tables(tables);

        const JoinTree &jt = join_trees[action.get_index()];

        std::unordered_map<int,std::vector<int>> thesis_indices;
        for (const auto &j : jt.get_order()) {
            //thesis_indices.insert({j.first,tables.at(j.first).tuple_index});
            //thesis_indices.insert({j.second,tables.at(j.second).tuple_index});
            unordered_set<int> project_over;
            for (auto x : tables[j.second].tuple_index) {
                project_over.insert(x);
            }
            for (auto x : tables[j.first].tuple_index) {
                if (distinguished_variables[action.get_index()].count(x) > 0) {
                    project_over.insert(x);
                }
            }
            Table &working_table = tables[j.second];
            hash_join(working_table, tables[j.first]);
            
            //save the result of the current hashjoin
            //thesis.insert_join_table(working_table);
            thesis_tables.at(action.get_index()).push_back(working_table);

            // Project must be after removal of inequality constraints, otherwise we might keep only the
            // tuple violating some inequality. Variables in inequalities are also considered
            // distinguished.
           

            filter_static(action, working_table);
            //if(working_table.EMPTY_TABLE){
                //copy = working_table;
            //}
            project(working_table, project_over);
            if (working_table.tuples.empty()) {
                return working_table;
            }
            //thesis_table = copy;
        }

        // For the case where the action schema is cyclic
        Table &working_table = tables[remaining_join[action.get_index()][0]];
        for (size_t i = 1; i < remaining_join[action.get_index()].size(); ++i) {
            hash_join(working_table, tables[remaining_join[action.get_index()][i]]);
            filter_static(action, working_table);
            if (working_table.tuples.empty()) {
                return working_table;
            }
        }

        project(working_table, distinguished_variables[action.get_index()]);
        return working_table;
    }

    
}
