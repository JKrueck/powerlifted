
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


//definitely need something better for this
//everything needs to be sorted in the same way or the diff operation doesnt work
void YannakakisSuccessorGenerator::filter_delete( std::vector<std::vector<Table>> &thesis_tables,std::vector<GroundAtom> &diff_delete, int action_id, std::vector<bool> &thesis_was_changed){
    for(auto diff_it:diff_delete){
        std::sort(diff_it.begin(),diff_it.end());
    }
    for(long unsigned int i=0; i<thesis_tables.at(action_id).size();i++){
        //cout << "Before del correction: "<< thesis_tables.at(action_id).at(i).tuples.size() << endl;
        bool flag = false;
        for(long unsigned int j=0; j<thesis_tables.at(action_id).at(i).tuples.size();){
            //copy for sorting
            Table thesis_sorted_table = thesis_tables.at(action_id).at(i);
            //Take the intersection between the deleted atoms and the tuple; if the result is non-zero delete it
            for(auto diff_it:diff_delete){ 
                std::sort(thesis_sorted_table.tuples.at(j).begin(),thesis_sorted_table.tuples.at(j).end());
                GroundAtom result;
                std::set_intersection(diff_it.begin(),diff_it.end(),thesis_sorted_table.tuples.at(j).begin(),thesis_sorted_table.tuples.at(j).end(), std::inserter(result,result.begin()));
                if(result.size() != 0){
                    //keep the counter on the right position
                    auto pos = thesis_tables.at(action_id).at(i).tuples.erase(thesis_tables.at(action_id).at(i).tuples.begin()+j);
                    j = pos - thesis_tables.at(action_id).at(i).tuples.begin();
                    flag = true;
                    if(j>=thesis_tables.at(action_id).at(i).tuples.size()){
                        break;
                    }
                }else{
                    j++;
                    if(j>=thesis_tables.at(action_id).at(i).tuples.size()){
                        break;
                    }
                }
            }
            
        }
        thesis_was_changed.at(i) = flag; 
    }
}

Table YannakakisSuccessorGenerator::thesis_instantiate2(const ActionSchema &action,const DBState &state,const Task &task, ThesisClass &thesis,
                            std::vector<std::vector<ThesisSave>> &thesis_tables, std::vector<std::vector<ThesisSave>> &thesis_semijoin, DBState &old_state)
{
    //cout << "used" << endl;
    if(action.get_index()==0){
        int borstenschwein = 0;
    }
    std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> predicate_to_add_diff = thesis.get_add_effect_map();
    std::unordered_map<int,bool>  diff_delete = thesis.get_del_eff();

    const JoinTree &jt = join_trees[action.get_index()];

    //if an add-effect does not appear in any join, only the added atom will be in the corresponding table in the end
    //if the action schema is cyclic this creates a bug in the partial reducer as the old atoms are missing
    std::unordered_map<int,bool> thesis_hack;
    int mega_idiot_counter = 0;
    for(auto precon:action.get_precondition()){
        for(auto join:jt.get_order()){
            if(join.first == mega_idiot_counter || join.second == mega_idiot_counter){
                thesis_hack.insert_or_assign(precon.get_predicate_symbol_idx(),true);
                break;
            }
        }
        mega_idiot_counter++;
    }
   
    //Save for which tables we need to re compute the hash join -- there can be more tables than predicates because of static preds
    std::unordered_map<int,bool> compute_hash_join;
    std::unordered_map<int,bool> compute_semi_join;
    for (unsigned long i=0; i<action.get_precondition().size();i++){
        if(predicate_to_add_diff.count(action.get_precondition().at(i).get_predicate_symbol_idx())!= 0 
            || diff_delete.count(action.get_precondition().at(i).get_predicate_symbol_idx())!= 0){
            compute_hash_join.insert({i,true});
            compute_semi_join.insert({i,true});
        }else{
            compute_hash_join.insert({i,false});
            compute_semi_join.insert({i,false});
        }
    }
    
    
   
    std::vector<bool> nullary = state.get_nullary_atoms();
    //Create a modified state with the new relations
    //DBState mod_state = DBState(std::move(new_relations), std::move(nullary));

    const auto &actiondata = action_data[action.get_index()];
    vector<Table> tables;
    auto res = parse_precond_into_join_program(actiondata, state, tables);
    if (!res){
        //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
        //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
        std::vector<ThesisSave> thesis_empty_joins;
        thesis_semijoin.at(action.get_index()) = std::move(thesis_empty_joins);
        //cout << "err1" << endl;
        return Table::EMPTY_TABLE();
    }
    assert(!tables.empty());
    assert(tables.size() == actiondata.relevant_precondition_atoms.size());
    
    
    std::unordered_map<int,int> thesis_affected_by_del;
    int idiot_counter = 0;
    for(auto it:action.get_precondition()){
        auto pos = diff_delete.find(it.get_predicate_symbol_idx());
        if(pos != diff_delete.end()){
            thesis_affected_by_del.insert_or_assign(idiot_counter,pos->first);
        }
        idiot_counter++;
    }

    //Tables that were affected by a del effect: Maps [Table] -> full reducer iteration
    std::unordered_map<int,int> affected_tables;



    int counter = 0;
    for (const pair<int, int> &sj : full_reducer_order[action.get_index()]) {  
            //If there is a change in the computation of this semi-join   
            if((compute_semi_join.at(sj.first) || compute_semi_join.at(sj.second)) && (affected_tables.count(sj.first)==0 && affected_tables.count(sj.second)==0)){
                std::pair<int,int> table_predicates;
                table_predicates.first = action.get_precondition().at(sj.first).get_predicate_symbol_idx();
                table_predicates.second = action.get_precondition().at(sj.second).get_predicate_symbol_idx();
                //If that change is(are) only a newly added atom(s) 
                if((thesis_affected_by_del.count(sj.second) == 0 && thesis_affected_by_del.count(sj.first) == 0) || thesis_affected_by_del.size() ==0){
                    //Get the new structure
                    ThesisSave &save_obj = thesis_semijoin.at(action.get_index()).at(counter);
                    
                    if(predicate_to_add_diff.count(table_predicates.first)!=0){
                        for(auto it:predicate_to_add_diff.at(table_predicates.first)){
                            //Generate the key for the newly added atom
                            std::vector<int> key(save_obj.matching_columns.size());
                            for(size_t i = 0; i < save_obj.matching_columns.size(); i++) {
                                key[i] = it[save_obj.matching_columns[i].second];
                            }
                            //Insert the new atom into the pos2 hashtable
                            save_obj.pos2_hashtable[key].insert(it);

                            if(save_obj.pos1_hashtable.count(key)!=0){
                                save_obj.result_table[key].insert(it);
                            }
                        }   
                    }
                    if(predicate_to_add_diff.count(table_predicates.second)!=0){
                        for(auto it:predicate_to_add_diff.at(table_predicates.second)){
                            //Generate the key for the newly added atom
                            std::vector<int> key(save_obj.matching_columns.size());
                            for(size_t i = 0; i < save_obj.matching_columns.size(); i++) {
                                key[i] = it[save_obj.matching_columns[i].first];
                            }
                            //Insert the new atom into the pos1 hashtable
                            save_obj.pos1_hashtable[key].insert(it);
                            if(save_obj.pos2_hashtable.count(key)!=0){
                                save_obj.result_table[key].insert(it);
                            }
                        }   
                    }
                    //Generate the WHOLE complete new_table
                    //Unnessescary probably
                    tables[sj.second] = save_obj.generate_table();
                    affected_tables.insert_or_assign(sj.second,counter);
                }else{//If that change was a delete effect (and maybe also add effect)
                    //Get the new structure
                    ThesisSave &save_obj = thesis_semijoin.at(action.get_index()).at(counter);

                    //Prepare all conditions
                    GroundAtom deleted_first;
                    GroundAtom deleted_second;
                    bool delete_condition1 = false;
                    bool delete_condition2 = false;

                    int predicate_impacted;

                    if(thesis_affected_by_del.count(sj.first)!=0){
                        deleted_first = thesis.deleted_facts.at(thesis_affected_by_del.at(sj.first));
                        delete_condition1 = true;
                        affected_tables.insert_or_assign(sj.first,counter);
                        affected_tables.insert_or_assign(sj.second,counter);
                    }
                    if(thesis_affected_by_del.count(sj.second)!=0){
                        deleted_second = thesis.deleted_facts.at(thesis_affected_by_del.at(sj.second));
                        delete_condition2 = true;
                        affected_tables.insert_or_assign(sj.second,counter);
                    }else{
                        predicate_impacted = thesis_affected_by_del.at(sj.first);
                        thesis_affected_by_del.insert_or_assign(sj.second,predicate_impacted);
                        //Remember that the table at the second position was affected by a del effecy
                    }
                    


                    if(delete_condition1){
                        //Generate the key for the removed added atom
                        std::vector<int> key(save_obj.matching_columns.size());
                        for(size_t i = 0; i < save_obj.matching_columns.size(); i++) {
                            key[i] = deleted_first[save_obj.matching_columns[i].second];
                        }
                        //Delete the TableEntry from the pos2 hashtable
                        if(save_obj.pos2_hashtable.count(key)!=0){
                            auto pos = save_obj.pos2_hashtable.at(key).find(deleted_first);
                            if(pos!=save_obj.pos2_hashtable.at(key).end()){
                                save_obj.pos2_hashtable.at(key).erase(pos);
                                //If the set has no entries left after removal, we can delete that key
                                //This also means that there is no match between pos1 and pos2 on that key
                                //If that key appears in the result it can thus be deleted
                                if(save_obj.pos2_hashtable.at(key).size()==0){
                                    save_obj.pos2_hashtable.erase(key);
                                    if(save_obj.result_table.count(key)!=0){
                                        save_obj.result_table.erase(key);
                                    }
                                }
                            }
                        }

                    }
                    if(delete_condition2){
                        //Generate the key for the removed added atom
                        std::vector<int> key(save_obj.matching_columns.size());
                        for(size_t i = 0; i < save_obj.matching_columns.size(); i++) {
                            key[i] = deleted_second[save_obj.matching_columns[i].first];
                        }
                        //Delete the TableEntry from the pos1 hashtable
                        if(save_obj.pos1_hashtable.count(key)!=0){
                            auto pos = save_obj.pos1_hashtable.at(key).find(deleted_second);
                            if(pos!=save_obj.pos1_hashtable.at(key).end()){//
                                save_obj.pos1_hashtable.at(key).erase(pos);
                                
                                //If the set has no entries left after removal, we can delete that key
                                //This also means that there is no match between pos1 and pos2 on that key
                                //If that key appears in the result it can thus be deleted
                                if(save_obj.pos1_hashtable.at(key).size()==0){//
                                    save_obj.pos1_hashtable.erase(key);
                                    if(save_obj.result_table.count(key)!=0){
                                        save_obj.result_table.erase(key);
                                    }
                                //If the set is not empty but the key does not appear in the pos2 hashtable, we can delete that key in the result too
                                }else if(save_obj.pos2_hashtable.count(key)==0){
                                    save_obj.result_table.erase(key);
                                }
                            }
                        }
   
                    }
                    //Now deal with any possible add-effects
                    if(predicate_to_add_diff.count(table_predicates.first)!=0){
                        for(auto it:predicate_to_add_diff.at(table_predicates.first)){
                            //Generate the key for the newly added atom
                            std::vector<int> key(save_obj.matching_columns.size());
                            for(size_t i = 0; i < save_obj.matching_columns.size(); i++) {
                                key[i] = it[save_obj.matching_columns[i].second];
                            }
                            //Insert the new atom into the pos2 hashtable
                            save_obj.pos2_hashtable[key].insert(it);

                            if(save_obj.pos1_hashtable.count(key)!=0){
                                for(auto elem:save_obj.pos1_hashtable[key]){
                                    save_obj.result_table[key].insert(elem);
                                }
                            }
                        }   
                    }
                    if(predicate_to_add_diff.count(table_predicates.second)!=0){
                        for(auto it:predicate_to_add_diff.at(table_predicates.second)){
                            //Generate the key for the newly added atom
                            std::vector<int> key(save_obj.matching_columns.size());
                            for(size_t i = 0; i < save_obj.matching_columns.size(); i++) {
                                key[i] = it[save_obj.matching_columns[i].first];
                            }
                            //Insert the new atom into the pos1 hashtable
                            save_obj.pos1_hashtable[key].insert(it);
                            int test = save_obj.pos2_hashtable.count(key);
                            if(save_obj.pos2_hashtable.count(key)!=0){
                                save_obj.result_table[key].insert(it);
                            }
                        }   
                    }

                    //Generate the WHOLE complete new_table
                    //Unnessescary probably
                    tables[sj.second] = save_obj.generate_table();
                    
                    //If the resulting semi-join was empty
                    if(tables[sj.second].tuples.size()==0){
                        //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                        //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                        std::vector<ThesisSave> thesis_empty_semijoins;
                        //cout << "err2" << endl;
                        thesis_semijoin.at(action.get_index()) = std::move(thesis_empty_semijoins);
                        return Table::EMPTY_TABLE();
                    }
                }
            }else if(affected_tables.count(sj.first)!=0 && affected_tables.count(sj.second) == 0 ){//Probably also need to do this for sj.first??
                //This is very similar to just computing a new semi-join --- talk about this
                //For this direction its probably easier to just compute the semi-join ?
                //Get the new structure
                ThesisSave &save_obj = thesis_semijoin.at(action.get_index()).at(counter);
                std::vector<std::vector<int>> new_tuples;
                //Clear the old pos1 hashtable and result
                save_obj.pos2_hashtable.clear();
                save_obj.result_table.clear();

                for(auto &tuple:tables[sj.first].tuples){
                    std::vector<int> key(save_obj.matching_columns.size());
                    for(size_t i = 0; i < save_obj.matching_columns.size(); i++) {
                        key[i] = tuple[save_obj.matching_columns[i].second];
                    }
                    save_obj.pos2_hashtable[key].insert(tuple);
                    if(save_obj.pos1_hashtable.count(key)!=0){
                        save_obj.result_table[key] = save_obj.pos1_hashtable[key];
                    }
                }
                tables[sj.second] = save_obj.generate_table();
                //If the resulting semi-join was empty
                if(tables[sj.second].tuples.size()==0){
                    //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                    //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                    std::vector<ThesisSave> thesis_empty_semijoins;
                    //cout << "err2" << endl;
                    thesis_semijoin.at(action.get_index()) = std::move(thesis_empty_semijoins);
                    return Table::EMPTY_TABLE();
                }
                
                affected_tables.insert_or_assign(sj.second,counter);

            }else if(affected_tables.count(sj.second)!=0 && affected_tables.count(sj.first) == 0){//Probably also need to do this for sj.first??
                /*
                The elements in table[sj.second] have changed in comparison to the same semi-join in the parent state
                This means that in contrast to Datalog Exploration, the position hashtables can persist between different join rules
                To account for this, we start by just doing the corresponding half of the semi-join, which updates the hash-table
                We can save ourselves the other half of the semi-join, as our memory on that SHOULD still be correct
                

                What if both tables have changed????
                For now do a full semi-join between them
                */
                //Get the new structure
                ThesisSave &save_obj = thesis_semijoin.at(action.get_index()).at(counter);
                std::vector<std::vector<int>> new_tuples;
                //Clear the old pos1 hashtable and result
                save_obj.pos1_hashtable.clear();
                save_obj.result_table.clear();

                for(auto &tuple:tables[sj.second].tuples){
                    std::vector<int> key(save_obj.matching_columns.size());
                    for(size_t i = 0; i < save_obj.matching_columns.size(); i++) {
                        key[i] = tuple[save_obj.matching_columns[i].first];
                    }
                    save_obj.pos1_hashtable[key].insert(tuple);

                    if(save_obj.pos2_hashtable.count(key)!=0){
                        new_tuples.push_back(tuple);
                        save_obj.result_table[key].insert(tuple);
                    }

                }
                save_obj.generate_table();
                tables[sj.second].tuples = std::move(new_tuples);
                //If the resulting semi-join was empty
                if(tables[sj.second].tuples.size()==0){
                    //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                    //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                    std::vector<ThesisSave> thesis_empty_semijoins;
                    //cout << "err2" << endl;
                    thesis_semijoin.at(action.get_index()) = std::move(thesis_empty_semijoins);
                    return Table::EMPTY_TABLE();
                }
            }else if(affected_tables.count(sj.first)!=0 && affected_tables.count(sj.second)!=0){
                ThesisSave dummy;
                semi_join(tables[sj.second],tables[sj.first],dummy);
                thesis_semijoin.at(action.get_index()).at(counter) = dummy;
                if(tables[sj.second].tuples.size()==0){
                    //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                    //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                    std::vector<ThesisSave> thesis_empty_semijoins;
                    //cout << "err2" << endl;
                    thesis_semijoin.at(action.get_index()) = std::move(thesis_empty_semijoins);
                    return Table::EMPTY_TABLE();
                }
            
            }else{
                tables[sj.second] = thesis_semijoin.at(action.get_index()).at(counter).result;
                tables[sj.second].tuple_index = thesis_semijoin.at(action.get_index()).at(counter).result_index;
            }
            counter++;
            /*for(auto tup:tables[sj.second].tuples){
                for(auto it:tup){
                    cout << it << " ";
                }
            }
            cout << endl;*/
    }

    //Temporary Solution for checking if this does work at all
    /*std::vector<bool> semijoin_was_updated(tables.size(),false);
    for(int i=0; i<semijoin_was_updated.size();i++){
        if(compute_semi_join.at(i)){
            bool flag = false;
            for(int j=full_reducer_order.at(action.get_index()).size()-1;j>=0 ;j--){
                if(full_reducer_order.at(action.get_index()).at(j).second == i){//&& predicate_to_add_diff.count(action.get_precondition().at(i).get_predicate_symbol_idx())==0
                    //tables[i].tuples.clear();
                    tables[i] = thesis_semijoin.at(action.get_index()).at(j);
                    semijoin_was_updated.at(i) = true;
                    flag = true;
                    break;
                }
            }
            if(!flag){
                tables[i].tuples.clear();
                select_tuples(state,action.get_precondition().at(i),tables[i].tuples,std::vector<int>());
            }
        }
    }*/
    
    


    //reset delete impact map
    diff_delete = thesis.get_del_eff();

    std::unordered_map<int,std::vector<int>> thesis_indices;
    counter = 0;
    for (const auto &j : jt.get_order()) {
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
        // Project must be after removal of inequality constraints, otherwise we might keep only the tuple violating
        // some inequality. Variables in inequalities are also considered distinguished.
        filter_static(action, working_table);
        project(working_table, project_over);
        if (working_table.tuples.empty()) {
            return working_table;
        }
    }

    
    
    /*Table &working_table = tables[remaining_join[action.get_index()][0]];
    //remaining_join[action.get_index()].size()==1
    if(remaining_join[action.get_index()].size()==1){
        working_table = thesis_tables.at(action.get_index()).back().result;
    }else{
        // For the case where the action schema is cyclic
        for (size_t i = 1; i < remaining_join[action.get_index()].size(); ++i) {
            hash_join(working_table, tables[remaining_join[action.get_index()][i]]);
            filter_static(action, working_table);
            if (working_table.tuples.empty()) {
                return working_table;
            }
        }
    }*/
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

void YannakakisSuccessorGenerator::thesis_compute_del_impacts(const Task &task){
    //std::vector<std::vector<std::pair<int,int>>> thesis_del_impacts;
    this->thesis_del_impacts.resize(task.get_action_schemas().size());
    for(auto it:task.get_action_schemas()){
        const JoinTree &jt = join_trees[it.get_index()];
        this->thesis_del_impacts[it.get_index()].resize(jt.get_order().size());
        int counter = 0;
        for (auto joins:jt.get_order()){
            Atom precondition_table_one = it.get_precondition().at(joins.first);
            Atom precondition_table_two = it.get_precondition().at(joins.second);
            this->thesis_del_impacts[it.get_index()].at(counter).first = precondition_table_one.get_predicate_symbol_idx();
            this->thesis_del_impacts[it.get_index()].at(counter).second = precondition_table_two.get_predicate_symbol_idx();
            counter++;
        }
        
    }

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
Table YannakakisSuccessorGenerator::instantiate(const ActionSchema &action, const DBState &state,
        const Task &task, ThesisClass &thesis, std::vector<std::vector<ThesisSave>> &thesis_tables, std::vector<std::vector<ThesisSave>> &thesis_semijoin, DBState &old_state)
{
    if (action.is_ground()) {
        throw std::runtime_error("Shouldn't be calling instantiate() on a ground action");
    }

    //if(!thesis_called){
      //  thesis_compute_del_impacts(task);
        //thesis_called = true;
    //}


    if(thesis.is_enabled() && thesis_semijoin.at(action.get_index()).size()!=0){
        Table thesis_return_table = thesis_instantiate2(action,state,task, thesis, thesis_tables, thesis_semijoin,old_state);
        return thesis_return_table;
    }else{ 
        const auto &actiondata = action_data[action.get_index()];
        

        vector<Table> tables;
        auto res = parse_precond_into_join_program(actiondata, state, tables);
        if (!res){
            //cout << "Here too" << endl;
            return Table::EMPTY_TABLE();
        }

        assert(!tables.empty());
        assert(tables.size() == actiondata.relevant_precondition_atoms.size());

        //if(action.get_index() == 7){
          //  int stop = 0;
        //}

        for (const pair<int, int> &sj : full_reducer_order[action.get_index()]) {
            ThesisSave semijoin_save;
            size_t s = semi_join(tables[sj.second], tables[sj.first], semijoin_save);
            if (s == 0) {
                //cout << " yann err1" << endl;
                std::vector<ThesisSave> thesis_empty_joins;
                thesis_semijoin.at(action.get_index()) = std::move(thesis_empty_joins);
                return Table::EMPTY_TABLE();
            }
            if(thesis.is_enabled()){
                thesis_semijoin.at(action.get_index()).push_back(semijoin_save);
            }
        }
    
        const JoinTree &jt = join_trees[action.get_index()];

        std::vector<bool> thesis_impacted(tables.size(),false);
        if(thesis.is_enabled()){
            thesis_tables.at(action.get_index()).resize(jt.get_order().size());
            for(auto it:action.get_effects()){
                if(it.is_negated()){
                    thesis_impacted[it.get_predicate_symbol_idx()] = true;
                }
            }
        }
        int counter = 0;
        for (const auto &j : jt.get_order()) {
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
            
            /*if(thesis.is_enabled()){
                if(thesis_impacted.at(j.first) || thesis_impacted.at(j.second)){
                    thesis_tables.at(action.get_index()).at(counter).first = working_table;
                    thesis_tables.at(action.get_index()).at(counter).second = true;
                    thesis_impacted[j.second] = true;
                }else{
                    thesis_tables.at(action.get_index()).at(counter).first = working_table;
                }
            }*/
           
            

            // Project must be after removal of inequality constraints, otherwise we might keep only the
            // tuple violating some inequality. Variables in inequalities are also considered
            // distinguished.
           

            filter_static(action, working_table);
            //if(working_table.EMPTY_TABLE){
                //copy = working_table;
            //}
            project(working_table, project_over);
            if (working_table.tuples.empty()) {
                //cout << " yann err2" << endl;
                return working_table;
            }
            counter++;
        }
        // For the case where the action schema is cyclic
        Table &working_table = tables[remaining_join[action.get_index()][0]];
        for (size_t i = 1; i < remaining_join[action.get_index()].size(); ++i) {
            hash_join(working_table, tables[remaining_join[action.get_index()][i]]);
            filter_static(action, working_table);
            if (working_table.tuples.empty()) {
                //cout << " yann err3" << endl;
                return working_table;
            }
        }

        project(working_table, distinguished_variables[action.get_index()]);
        return working_table;
    }

    
}
