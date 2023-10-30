
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

void YannakakisSuccessorGenerator::deal_with_add_semi(std::pair<int,int> &table_predicates, ThesisSave &save, std::unordered_set<GroundAtom,TupleHash> add_diff, bool first){
    int predicate;
    if(first){
        predicate = table_predicates.second;
    }else{
        predicate = table_predicates.first;
    }

    for(auto it:add_diff){
        //Generate the key for the newly added atom
        std::vector<int> key(save.matching_columns.size());
        for(size_t i = 0; i < save.matching_columns.size(); i++) {
           if(first){
                key[i] = it[save.matching_columns[i].first];
            }else{
                key[i] = it[save.matching_columns[i].second];
            }
        }

        if(first){
            //Insert the new atom into the pos1 hashtable
            save.pos1_hashtable[key].insert(it);
            if(save.pos2_hashtable.count(key)!=0){
                save.result_table[key].insert(it);
                //Remember that we added this
                save.pos1_added.insert(it);
            }
        }else{
            //Insert the new atom into the pos2 hashtable
            save.pos2_hashtable[key].insert(it);
            //If that key also exists in pos1 and not in the result yet, then the semi-join now is able to retain that key from pos1
            if(save.pos1_hashtable.count(key)!=0 && save.result_table.count(key) == 0){
                for(auto pos1:save.pos1_hashtable[key]){
                    save.result_table[key].insert(pos1);
                    //Remember that we added this here
                    save.pos1_added.insert(pos1);
                }
            }
        }
    }   
}
void YannakakisSuccessorGenerator::deal_with_del_semi(std::pair<int,int> &table_predicates, ThesisSave &save, std::unordered_set<GroundAtom,TupleHash> del_diff, bool first){
    for(auto del:del_diff){
        //Generate the key for the removed added atom
        std::vector<int> key(save.matching_columns.size());
        for(size_t i = 0; i < save.matching_columns.size(); i++) {
            if(first){
                key[i] = del[save.matching_columns[i].first];
            }else{
                key[i] = del[save.matching_columns[i].second];
            }
        }
        if(first){
            //Delete the TableEntry from the pos1 hashtable
            if(save.pos1_hashtable.count(key)!=0){
                //As the element at save_obj.pos1_hashtable.at(key) is a unordered_set, this takes constant time on average
                auto pos = save.pos1_hashtable.at(key).find(del);
                if(pos!=save.pos1_hashtable.at(key).end()){//
                    save.pos1_hashtable.at(key).erase(pos);
                    //Remember that del has been deleted from this table
                    save.pos1_deleted.insert(del);
                    
                    //If the set has no entries left after removal, we can delete that key
                    //This also means that there is no match between pos1 and pos2 on that key
                    //If that key appears in the result it can thus be deleted
                    if(save.pos1_hashtable.at(key).size()==0){//
                        save.pos1_hashtable.erase(key);
                        if(save.result_table.count(key)!=0){
                            save.result_table.erase(key);
                        }
                    //If the set is not empty but the key does not appear in the pos2 hashtable, we can delete that key in the result too
                    }else if(save.pos2_hashtable.count(key)==0){
                        save.result_table.erase(key);
                    }else{
                        save.result_table.insert_or_assign(key,save.pos1_hashtable[key]);
                    }
                }
            }
        }else{
            //Delete the TableEntry from the pos2 hashtable
            if(save.pos2_hashtable.count(key)!=0){
                auto pos = save.pos2_hashtable.at(key).find(del);
                if(pos!=save.pos2_hashtable.at(key).end()){
                    save.pos2_hashtable.at(key).erase(pos);
                    //If the set has no entries left after removal, we can delete that key
                    //This also means that there is no match between pos1 and pos2 on that key
                    //If that key appears in the result it can thus be deleted
                    if(save.pos2_hashtable.at(key).size()==0){
                        save.pos2_hashtable.erase(key);
                        if(save.result_table.count(key)!=0){
                            //Save the atoms that were removed from pos1 due to changes in pos2
                            for(auto it:save.result_table[key]){
                                save.pos1_deleted.insert(it);
                            }
                            save.result_table.erase(key);
                        }
                    }
                }
            }
        }
    }

}
void YannakakisSuccessorGenerator::deal_with_add_full(std::pair<int,int> &table_predicates, ThesisSave &save, std::unordered_set<GroundAtom,TupleHash> add_diff, bool first, int index_size){
    int predicate;
    if(first){
        predicate = table_predicates.second;
    }else{
        predicate = table_predicates.first;
    }

    for(auto it:add_diff){
        //Generate the key for the newly added atom
        std::vector<int> key(save.matching_columns.size());
        for(size_t i = 0; i < save.matching_columns.size(); i++) {
           if(first){
                key[i] = it[save.matching_columns[i].first];
            }else{
                key[i] = it[save.matching_columns[i].second];
            }
        }
        std::vector<bool> to_remove_me(index_size, false);
        for (const auto &m : save.matching_columns) {
            to_remove_me[m.second] = true;
        }

        if(first){
            //Insert the new atom into the pos1 hashtable
            save.pos1_hashtable[key].insert(it);
            if(save.pos2_hashtable.count(key)!=0){
                //unnessescary??Still not sure if changing the for each element changes the real one
                auto copy = it;
                /*Go trough all entries in the second pos table that match the new one
                Add the corresponding elements from the second table to our new atom
                */
                std::unordered_set<GroundAtom, TupleHash> to_add = save.pos2_hashtable[key];
                for(auto tup:to_add){
                    for (unsigned j = 0; j < to_remove_me.size(); ++j) {
                        if (!to_remove_me[j]) copy.push_back(tup[j]);
                    }
                    save.result_table[key].insert(copy);
                    //Remember that we added something
                    save.pos1_added.insert(copy);
                }
            }
        }else{
            //Insert the new atom into the pos2 hashtable if it isnt there yet
            if(save.pos2_hashtable[key].find(it)==save.pos2_hashtable[key].end()){
                save.pos2_hashtable[key].insert(it);
                //If that key also exists in pos1 and not in the result yet, then the semi-join now is able to retain that key from pos1
                if(save.pos1_hashtable.count(key)!=0){
                    //Normal probe phase
                    std::unordered_set<GroundAtom, TupleHash> to_change = save.pos1_hashtable[key];
                    for(auto tup:to_change){
                        for (unsigned j = 0; j < to_remove_me.size(); ++j) {
                            if (!to_remove_me[j]) tup.push_back(it[j]);
                        }
                        save.result_table[key].insert(tup);
                        save.pos1_added.insert(tup);
                    }
                }
            }
        }
    }   
}
void YannakakisSuccessorGenerator::deal_with_del_full(std::pair<int,int> &table_predicates, ThesisSave &save, std::unordered_set<GroundAtom,TupleHash> del_diff, bool first, int index_size){
    for(auto del:del_diff){
        //Generate the key for the removed added atom
        std::vector<int> key(save.matching_columns.size());
        for(size_t i = 0; i < save.matching_columns.size(); i++) {
            if(first){
                key[i] = del[save.matching_columns[i].first];
            }else{
                key[i] = del[save.matching_columns[i].second];
            }
        }
        std::vector<bool> to_remove_me(index_size, false);
        for (const auto &m : save.matching_columns) {
            to_remove_me[m.second] = true;
        }
        if(first){
            if(save.del_res && save.result_table.count(key)!=0){
                auto pos = save.result_table.at(key).find(del);
                if(pos!=save.result_table.at(key).end()){//
                    save.result_table.at(key).erase(pos);
                    //Remember that del has been deleted from this table
                    save.result_deleted.insert(del);
                    if(save.result_table[key].size()==0){
                        save.result_table.erase(key);
                    }
                }
            }else{
                //Delete the TableEntry from the pos1 hashtable
                if(save.pos1_hashtable.count(key)!=0){
                    //As the element at save_obj.pos1_hashtable.at(key) is a unordered_set, this takes constant time on average
                    auto pos = save.pos1_hashtable.at(key).find(del);
                    if(pos!=save.pos1_hashtable.at(key).end()){//
                        save.pos1_hashtable.at(key).erase(pos);
                        //Remember that del has been deleted from this table
                        save.pos1_deleted.insert(del);
                        
                        //If the set has no entries left after removal, we can delete that key
                        //This also means that there is no match between pos1 and pos2 on that key
                        //If that key appears in the result it can thus be deleted
                        if(save.pos1_hashtable.at(key).size()==0){//
                            save.pos1_hashtable.erase(key);
                            if(save.result_table.count(key)!=0){
                                save.result_table.erase(key);
                            }
                        //If the set is not empty but the key does not appear in the pos2 hashtable, we can delete that key in the result too
                        //Does this even occur????
                        }else if(save.pos2_hashtable.count(key)==0){
                            save.result_table.erase(key);
                        }else{//If there are still entries for that key in both tables, we need to remove the results that match the removed element
                            //Generate the atoms that wont exist anymore and then erase them
                            auto copy = del;
                            std::unordered_set<GroundAtom, TupleHash> to_add = save.pos2_hashtable[key];
                            for(auto tup:to_add){
                                for (unsigned j = 0; j < to_remove_me.size(); ++j) {
                                    if (!to_remove_me[j]) copy.push_back(tup[j]);
                                }
                                save.result_table[key].erase(copy);
                            }
                            //Hope this case is infrequent
                        }
                    }
                }
            }
        }else{
            //Delete the TableEntry from the pos2 hashtable
            if(save.pos2_hashtable.count(key)!=0){
                auto pos = save.pos2_hashtable.at(key).find(del);
                if(pos!=save.pos2_hashtable.at(key).end()){
                    save.pos2_hashtable.at(key).erase(pos);
                    //If the set has no entries left after removal, we can delete that key
                    //This also means that there is no match between pos1 and pos2 on that key
                    //If that key appears in the result it can thus be deleted
                    if(save.pos2_hashtable.at(key).size()==0){
                        save.pos2_hashtable.erase(key);
                        if(save.result_table.count(key)!=0){
                            for(auto it:save.result_table[key]){
                                //Save the atoms that were removed from pos1 due to changes in pos2
                                //We only want the atoms from the result that originated from pos1
                                //Calculate how many elements in the result are from the second table by subtracting the size of the overlap(match) from the size of the elements in pos2(index_size)
                                //you're welcome future me
                                //int num = it.size()-(index_size-save.matching_columns.size());
                                //GroundAtom range(it.begin(),it.begin()+num);
                                save.result_deleted.insert(it);
                            }
                            save.result_table.erase(key);
                        }
                    }
                    //Why only one case here?? Just lucky no test isntance covers this??
                    //Write my own test maye
                }
            }
        }
    }

}


Table YannakakisSuccessorGenerator::thesis_instantiate2(const ActionSchema &action,const DBState &state,const Task &task, ThesisClass &thesis,
                            std::vector<std::vector<ThesisSave>> &thesis_tables, std::vector<std::vector<ThesisSave>> &thesis_semijoin, DBState &old_state)
{
    //cout << "used" << endl;
    thesis.counter_me++;
    time_t full_time = clock();
    if(action.get_index()==0){
        int borstenschwein = 0;
    }
    std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> predicate_to_add_diff = thesis.get_add_effect_map();
    std::unordered_map<int,bool>  diff_delete = thesis.get_del_eff();

    const JoinTree &jt = join_trees[action.get_index()];

    //if an add-effect does not appear in any join, only the added atom will be in the corresponding table in the end
    //if the action schema is cyclic this creates a bug in the partial reducer as the old atoms are missing
    //Probably dont need this anymore --- 17.10
    /*std::unordered_map<int,bool> thesis_hack;
    int mega_idiot_counter = 0;
    for(auto precon:action.get_precondition()){
        for(auto join:jt.get_order()){
            if(join.first == mega_idiot_counter || join.second == mega_idiot_counter){
                thesis_hack.insert_or_assign(precon.get_predicate_symbol_idx(),true);
                break;
            }
        }
        mega_idiot_counter++;
    }*/
   
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

    time_t tables_time = clock();
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
    thesis.time_tables_me += clock()-tables_time;
    
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
    std::pair<int,int> table_predicates;

    time_t full_reducer = clock();
    int counter = 0;
    for (const pair<int, int> &sj : full_reducer_order[action.get_index()]) {  
            table_predicates.first = action.get_precondition().at(sj.first).get_predicate_symbol_idx();
            table_predicates.second = action.get_precondition().at(sj.second).get_predicate_symbol_idx();
            //If there is a change in the computation of this semi-join   
            if((compute_semi_join.at(sj.first) || compute_semi_join.at(sj.second)) && (affected_tables.count(sj.first)==0 && affected_tables.count(sj.second)==0)){
                //If that change is(are) only a newly added atom(s) 
                if((thesis_affected_by_del.count(sj.second) == 0 && thesis_affected_by_del.count(sj.first) == 0) || thesis_affected_by_del.size() ==0){
                    //Get the new structure
                    ThesisSave &save_obj = thesis_semijoin.at(action.get_index()).at(counter);
                    
                    if(predicate_to_add_diff.count(table_predicates.first)!=0){

                        deal_with_add_semi(table_predicates,save_obj, predicate_to_add_diff.at(table_predicates.first),false);

                    }
                    if(predicate_to_add_diff.count(table_predicates.second)!=0){
                        
                        deal_with_add_semi(table_predicates,save_obj, predicate_to_add_diff.at(table_predicates.second),true);
                    
                    }
                    //Generate the WHOLE complete new_table
                    //Unnessescary probably
                    tables[sj.second] = save_obj.generate_table();
                    affected_tables.insert_or_assign(sj.second,counter);
                }else{//If that change was a delete effect (and maybe also add effect)
                    //Get the new structure
                    ThesisSave &save_obj = thesis_semijoin.at(action.get_index()).at(counter);
                   
                    //Prepare all conditions
                    std::unordered_set<GroundAtom,TupleHash> deleted_first;
                    std::unordered_set<GroundAtom,TupleHash> deleted_second;
                    bool delete_condition1 = false;
                    bool delete_condition2 = false;

                    if(thesis_affected_by_del.count(sj.first)!=0){
                        deleted_first = thesis.deleted_facts.at(thesis_affected_by_del.at(sj.first));
                        delete_condition1 = true;
                        affected_tables.insert_or_assign(sj.second,counter);
                    }
                    if(thesis_affected_by_del.count(sj.second)!=0){
                        deleted_second = thesis.deleted_facts.at(thesis_affected_by_del.at(sj.second));
                        delete_condition2 = true;
                        affected_tables.insert_or_assign(sj.second,counter);
                    }else{
                        //predicate_impacted = thesis_affected_by_del.at(sj.first);
                        //thesis_affected_by_del.insert_or_assign(sj.second,predicate_impacted);
                        //Remember that the table at the second position was affected by a del effecy
                        affected_tables.insert_or_assign(sj.second,counter);
                    }
                        


                    //Firstly deal with any possible add-effects
                    if(predicate_to_add_diff.count(table_predicates.first)!=0) deal_with_add_semi(table_predicates,save_obj, predicate_to_add_diff.at(table_predicates.first),false);
                    if(predicate_to_add_diff.count(table_predicates.second)!=0) deal_with_add_semi(table_predicates,save_obj,predicate_to_add_diff.at(table_predicates.second),true);
                    //Now deal with deletes
                    if(delete_condition1) deal_with_del_semi(table_predicates, save_obj,deleted_first, false);
                    if(delete_condition2) deal_with_del_semi(table_predicates, save_obj,deleted_second, true);

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
            }else if(affected_tables.count(sj.first)!=0 && affected_tables.count(sj.second) == 0 ){
                //This is very similar to just computing a new semi-join --- talk about this
                //For this direction its probably easier to just compute the semi-join ?
                //Get the new structure
                ThesisSave &save_obj = thesis_semijoin.at(action.get_index()).at(counter);
                ThesisSave &old_save = thesis_semijoin.at(action.get_index()).at(affected_tables[sj.first]);
                //There are some cases in which the semi-join in the initial state was interrupted due to there being no matching columns
                //If that was the case we need to do a full semi-join
                //Do we?? If there weren´t any matching columns in the initial state, there will never be
                //This will just call the semi-join function, which then determines that there are no matching columns and returns tables[sj.second] unchanged
                //Can do this faster
                if(save_obj.matching_columns.size()==0){
                    semi_join(tables[sj.second],tables[sj.first],save_obj);
                    save_obj.pos1_added = old_save.pos1_added;
                    save_obj.pos1_deleted = old_save.pos1_deleted;
                }else{
                    
                    deal_with_add_semi(table_predicates, save_obj, old_save.pos1_added, false);
                    deal_with_del_semi(table_predicates, save_obj, old_save.pos1_deleted, false);
                    
                    //It can happen that there are still changes that need to be made to the second table
                    if(compute_semi_join[sj.second]){
                        std::unordered_set<GroundAtom, TupleHash> deleted_second;
                        bool delete_condition2 = false;
                        if(thesis_affected_by_del.count(sj.second)!=0){
                            deleted_second = thesis.deleted_facts.at(thesis_affected_by_del.at(sj.second));
                            delete_condition2 = true;
                            affected_tables.insert_or_assign(sj.second,counter);
                        }
                        if(predicate_to_add_diff.count(action.get_precondition().at(sj.second).get_predicate_symbol_idx())!=0) deal_with_add_semi(table_predicates, save_obj, predicate_to_add_diff.at(table_predicates.second), 1);
                        if(delete_condition2) deal_with_del_semi(table_predicates, save_obj, deleted_second, true);
                    }

                    
                    tables[sj.second] = save_obj.generate_table();
                }
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

            }else if(affected_tables.count(sj.second)!=0 && affected_tables.count(sj.first) == 0){
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
                ThesisSave &old_save = thesis_semijoin.at(action.get_index()).at(affected_tables[sj.second]);
                //There are some cases in which the semi-join in the initial state was interrupted due to there being no matching columns
                //If that was the case we need to do a full semi-join
                //See comments above
                if(save_obj.matching_columns.size()==0){
                    semi_join(tables[sj.second],tables[sj.first],save_obj);
                    save_obj.pos1_added = old_save.pos1_added;
                    save_obj.pos1_deleted = old_save.pos1_deleted;
                }else{

                    deal_with_add_semi(table_predicates, save_obj, old_save.pos1_added, true);
                    deal_with_del_semi(table_predicates, save_obj, old_save.pos1_deleted, true);
                    tables[sj.second] = save_obj.generate_table();
                }
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
            }else if(affected_tables.count(sj.first)!=0 && affected_tables.count(sj.second)!=0){
                //Get the new structure
                ThesisSave &save_obj = thesis_semijoin.at(action.get_index()).at(counter);
                //Get the old structures
                ThesisSave &old_save_pos1 = thesis_semijoin.at(action.get_index()).at(affected_tables[sj.second]);
                ThesisSave &old_save_pos2 = thesis_semijoin.at(action.get_index()).at(affected_tables[sj.first]);
                if(save_obj.matching_columns.size()==0){
                    semi_join(tables[sj.second],tables[sj.first],save_obj);
                    save_obj.pos1_added = old_save_pos1.pos1_added;
                    save_obj.pos1_deleted = old_save_pos1.pos1_deleted;
                }else{

                    deal_with_add_semi(table_predicates, save_obj, old_save_pos1.pos1_added, true);
                    deal_with_add_semi(table_predicates, save_obj, old_save_pos2.pos1_added, false);
                    
                    deal_with_del_semi(table_predicates, save_obj, old_save_pos1.pos1_deleted, true);
                    deal_with_del_semi(table_predicates, save_obj, old_save_pos2.pos1_deleted, false);
                    
                    tables[sj.second] = save_obj.generate_table();
                }
                //ThesisSave dummy;
                //semi_join(tables[sj.second],tables[sj.first],dummy);
                //thesis_semijoin.at(action.get_index()).at(counter) = dummy;
                if(tables[sj.second].tuples.size()==0){
                    //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                    //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                    std::vector<ThesisSave> thesis_empty_semijoins;
                    //cout << "err2" << endl;
                    thesis_semijoin.at(action.get_index()) = std::move(thesis_empty_semijoins);
                    return Table::EMPTY_TABLE();
                }
                affected_tables.insert_or_assign(sj.second,counter);
            }else{
                tables[sj.second] = thesis_semijoin.at(action.get_index()).at(counter).result;
                tables[sj.second].tuple_index = thesis_semijoin.at(action.get_index()).at(counter).result_index;
            }
            counter++;
    }

    //We have stored everything that was deleted/added to some table
    //If this storage isn´t cleared we will continue to add/delete these atoms in future states as the data structures are carried over betweens states 
    for(int i=0;i<thesis_semijoin.at(action.get_index()).size();i++){
        thesis_semijoin.at(action.get_index()).at(i).refresh_tables();
    }
    affected_tables.clear();
    thesis.fullreducer_time_me+= clock()-full_reducer;

    //Irgendwie merken was für dinge aus dem zweiten table an den ersten angebaut wurde vielleicht??


    counter = 0;
    /*for (const auto &j : jt.get_order()) {
        table_predicates.first = action.get_precondition().at(j.first).get_predicate_symbol_idx();
        table_predicates.second = action.get_precondition().at(j.second).get_predicate_symbol_idx();
        //If there is a change in the computation of this join   
        if((compute_hash_join.at(j.first) || compute_hash_join.at(j.second)) && (affected_tables.count(j.first)==0 && affected_tables.count(j.second)==0)){
            //If that change(s) is(are) only a newly added atom(s) 
            if((thesis_affected_by_del.count(j.second) == 0 && thesis_affected_by_del.count(j.first) == 0) || thesis_affected_by_del.size() ==0){
                //Get the new structure
                ThesisSave &save_obj = thesis_tables.at(action.get_index()).at(counter);
                
                if(predicate_to_add_diff.count(table_predicates.first)!=0) deal_with_add_full(table_predicates,save_obj, predicate_to_add_diff.at(table_predicates.first),false,tables[j.first].tuple_index.size());


                if(predicate_to_add_diff.count(table_predicates.second)!=0) deal_with_add_full(table_predicates,save_obj, predicate_to_add_diff.at(table_predicates.second),true,tables[j.first].tuple_index.size());
                

                //Generate the WHOLE complete new_table
                //Unnessescary probably
                tables[j.second] = save_obj.generate_table();
                affected_tables.insert_or_assign(j.second,counter);
            }else{//If that change was a delete effect (and maybe also add effect)
                //Get the new structure
                ThesisSave &save_obj = thesis_tables.at(action.get_index()).at(counter);
                
                //Prepare all conditions
                std::unordered_set<GroundAtom,TupleHash> deleted_first;
                std::unordered_set<GroundAtom,TupleHash> deleted_second;
                bool delete_condition1 = false;
                bool delete_condition2 = false;


                if(thesis_affected_by_del.count(j.first)!=0){
                    deleted_first = thesis.deleted_facts.at(thesis_affected_by_del.at(j.first));
                    delete_condition1 = true;
                    affected_tables.insert_or_assign(j.second,counter);
                }
                if(thesis_affected_by_del.count(j.second)!=0){
                    deleted_second = thesis.deleted_facts.at(thesis_affected_by_del.at(j.second));
                    delete_condition2 = true;
                    affected_tables.insert_or_assign(j.second,counter);
                }else{
                    //thesis_affected_by_del.insert_or_assign(sj.second,predicate_impacted);
                    //Remember that the table at the second position was affected by a del effecy
                    affected_tables.insert_or_assign(j.second,counter);
                }
                    


                //Firstly deal with any possible add-effects
                if(predicate_to_add_diff.count(table_predicates.first)!=0) deal_with_add_full(table_predicates,save_obj, predicate_to_add_diff.at(table_predicates.first), false, tables[j.first].tuple_index.size());
                if(predicate_to_add_diff.count(table_predicates.second)!=0) deal_with_add_full(table_predicates,save_obj,predicate_to_add_diff.at(table_predicates.second), true, tables[j.first].tuple_index.size());
                //Now deal with deletes
                if(delete_condition1) deal_with_del_full(table_predicates, save_obj,deleted_first, false,tables[j.first].tuple_index.size());
                if(delete_condition2) deal_with_del_full(table_predicates, save_obj,deleted_second, true, tables[j.first].tuple_index.size());

                //Generate the WHOLE complete new_table
                //Unnessescary probably
                tables[j.second] = save_obj.generate_table();
                
                //If the resulting semi-join was empty
                if(tables[j.second].tuples.size()==0){
                    std::vector<ThesisSave> thesis_empty_semijoins;
                    thesis_tables.at(action.get_index()) = std::move(thesis_empty_semijoins);
                    return Table::EMPTY_TABLE();
                }
            }
        }else if(affected_tables.count(j.first)!=0 && affected_tables.count(j.second) == 0 ){
            //This is very similar to just computing a new semi-join --- talk about this
            //For this direction its probably easier to just compute the semi-join ?
            //Get the new structure
            ThesisSave &save_obj = thesis_tables.at(action.get_index()).at(counter);
            ThesisSave &old_save = thesis_tables.at(action.get_index()).at(affected_tables[j.first]);
            //There are some cases in which the semi-join in the initial state was interrupted due to there being no matching columns
            //If that was the case we need to do a full semi-join that will compute the cartesian product
            if(save_obj.matching_columns.size()==0){
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
                hash_join(working_table, tables[j.first], save_obj);
                filter_static(action, working_table);
                project(working_table, project_over);
                save_obj.pos1_added = old_save.pos1_added;
                save_obj.pos1_deleted = old_save.pos1_deleted;
            }else{
                
                deal_with_add_full(table_predicates, save_obj, old_save.pos1_added, false, tables[j.first].tuple_index.size());
                deal_with_del_full(table_predicates, save_obj, old_save.pos1_deleted, false,  tables[j.first].tuple_index.size());
                save_obj.del_res = true;
                deal_with_del_full(table_predicates, save_obj, old_save.result_deleted, false, tables[j.first].tuple_index.size());

                
                //It can happen that there are still changes that need to be made to the second table
                if(compute_semi_join[j.second]){
                    std::unordered_set<GroundAtom, TupleHash> deleted_second;
                    bool delete_condition2 = false;
                    if(thesis_affected_by_del.count(j.second)!=0){
                        deleted_second = thesis.deleted_facts.at(thesis_affected_by_del.at(j.second));
                        delete_condition2 = true;
                        affected_tables.insert_or_assign(j.second,counter);
                    }
                    if(predicate_to_add_diff.count(action.get_precondition().at(j.second).get_predicate_symbol_idx())!=0) deal_with_add_full(table_predicates, save_obj, predicate_to_add_diff.at(table_predicates.second), true, tables[j.first].tuple_index.size());
                    if(delete_condition2) deal_with_del_full(table_predicates, save_obj, deleted_second, true, tables[j.first].tuple_index.size());
                }

                
                tables[j.second] = save_obj.generate_table();
            }
            //If the resulting semi-join was empty
            if(tables[j.second].tuples.size()==0){
                //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                std::vector<ThesisSave> thesis_empty_semijoins;
                //cout << "err2" << endl;
                thesis_tables.at(action.get_index()) = std::move(thesis_empty_semijoins);
                return Table::EMPTY_TABLE();
            }
            
            affected_tables.insert_or_assign(j.second,counter);
        }else if(affected_tables.count(j.second)!=0 && affected_tables.count(j.first) == 0){
            //Get the new structure
            ThesisSave &save_obj = thesis_tables.at(action.get_index()).at(counter);
            ThesisSave &old_save = thesis_tables.at(action.get_index()).at(affected_tables[j.second]);
            //There are some cases in which the semi-join in the initial state was interrupted due to there being no matching columns
            //If that was the case we need to do a full join that will calculate the cartesian product
            if(save_obj.matching_columns.size()==0){
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
                hash_join(working_table, tables[j.first], save_obj);
                filter_static(action, working_table);
                project(working_table, project_over);
                save_obj.pos1_added = old_save.pos1_added;
                save_obj.pos1_deleted = old_save.pos1_deleted;
            }else{

                deal_with_add_full(table_predicates, save_obj, old_save.pos1_added, true, tables[j.first].tuple_index.size());
                deal_with_del_full(table_predicates, save_obj, old_save.pos1_deleted, true, tables[j.first].tuple_index.size());
                save_obj.del_res = true;
                deal_with_del_full(table_predicates, save_obj, old_save.result_deleted, true, tables[j.first].tuple_index.size());
                tables[j.second] = save_obj.generate_table();
            }
            //If the resulting semi-join was empty
            if(tables[j.second].tuples.size()==0){
                //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                std::vector<ThesisSave> thesis_empty_semijoins;
                //cout << "err2" << endl;
                thesis_tables.at(action.get_index()) = std::move(thesis_empty_semijoins);
                return Table::EMPTY_TABLE();
            }
            affected_tables.insert_or_assign(j.second,counter);
        }else if(affected_tables.count(j.first)!=0 && affected_tables.count(j.second)!=0){
            //Get the new structure
            ThesisSave &save_obj = thesis_tables.at(action.get_index()).at(counter);
            //Get the old structures
            ThesisSave &old_save_pos1 = thesis_tables.at(action.get_index()).at(affected_tables[j.second]);
            ThesisSave &old_save_pos2 = thesis_tables.at(action.get_index()).at(affected_tables[j.first]);
            if(save_obj.matching_columns.size()==0){
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
                hash_join(working_table, tables[j.first], save_obj);
                filter_static(action, working_table);
                project(working_table, project_over);
                save_obj.pos1_added = old_save_pos1.pos1_added;
                save_obj.pos1_deleted = old_save_pos1.pos1_deleted;
            }else{

                deal_with_add_full(table_predicates, save_obj, old_save_pos1.pos1_added, true, tables[j.first].tuple_index.size());
                deal_with_add_full(table_predicates, save_obj, old_save_pos2.pos1_added, false, tables[j.first].tuple_index.size());
                
                deal_with_del_full(table_predicates, save_obj, old_save_pos1.pos1_deleted, true, tables[j.first].tuple_index.size());
                save_obj.del_res = true;
                deal_with_del_full(table_predicates, save_obj, old_save_pos1.result_deleted, true, tables[j.first].tuple_index.size());
                deal_with_del_full(table_predicates, save_obj, old_save_pos2.pos1_deleted, false, tables[j.first].tuple_index.size());
                save_obj.del_res = true;
                deal_with_del_full(table_predicates, save_obj, old_save_pos2.result_deleted, false, tables[j.first].tuple_index.size());
                
                tables[j.second] = save_obj.generate_table();
            }
            if(tables[j.second].tuples.size()==0){
                //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                std::vector<ThesisSave> thesis_empty_semijoins;
                //cout << "err2" << endl;
                thesis_tables.at(action.get_index()) = std::move(thesis_empty_semijoins);
                return Table::EMPTY_TABLE();
            }
            affected_tables.insert_or_assign(j.second,counter);
        }else{
            tables[j.second] = thesis_tables.at(action.get_index()).at(counter).result;
            tables[j.second].tuple_index = thesis_tables.at(action.get_index()).at(counter).result_index;
        }
        counter++;
    }*/

    
    counter = 0;
    time_t join = clock();
    for (const auto &j : jt.get_order()) {
        ThesisSave join_save;
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
        hash_join(working_table, tables[j.first], join_save);
        // Project must be after removal of inequality constraints, otherwise we might keep only the tuple violating
        // some inequality. Variables in inequalities are also considered distinguished.
        filter_static(action, working_table);
        project(working_table, project_over);
        if (working_table.tuples.empty()) {
            return working_table;
        }
    }

    Table &working_table = tables[remaining_join[action.get_index()][0]];
    for (size_t i = 1; i < remaining_join[action.get_index()].size(); ++i) {
        ThesisSave join_save;
        hash_join(working_table, tables[remaining_join[action.get_index()][i]], join_save);
        filter_static(action, working_table);
        if (working_table.tuples.empty()) {
            return working_table;
        }
    }
    /*for(int i=0;i<thesis_tables.at(action.get_index()).size();i++){
        thesis_tables.at(action.get_index()).at(i).refresh_tables();
    }*/

    thesis.joinstep_time_me += clock()-join;
    project(working_table, distinguished_variables[action.get_index()]);
    thesis.time_me+= clock()- full_time;
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
        thesis.counter_normal++;
        time_t full_time = clock();
        const auto &actiondata = action_data[action.get_index()];
        
        time_t tables_time = clock();
        vector<Table> tables;
        auto res = parse_precond_into_join_program(actiondata, state, tables);
        if (!res){
            //cout << "Here too" << endl;
            return Table::EMPTY_TABLE();
        }
        thesis.time_tables_normal = clock()-tables_time;

        assert(!tables.empty());
        assert(tables.size() == actiondata.relevant_precondition_atoms.size());
        thesis.time_tables_me += clock()-tables_time;

        if(action.get_index() == 2){
            int stop = 0;
        }
        time_t full_red = clock();
        for (const pair<int, int> &sj : full_reducer_order[action.get_index()]) {
            ThesisSave semijoin_save;
            size_t s = semi_join(tables[sj.second], tables[sj.first], semijoin_save);
            if (s == 0) {
                std::vector<ThesisSave> thesis_empty_joins;
                thesis_semijoin.at(action.get_index()) = std::move(thesis_empty_joins);
                return Table::EMPTY_TABLE();
            }
            if(thesis.is_enabled()){
                thesis_semijoin.at(action.get_index()).push_back(semijoin_save);
            }
        }
        thesis.fullreducer_time_normal+= clock() - full_red;
    
        const JoinTree &jt = join_trees[action.get_index()];
        std::vector<bool> thesis_size_changed(tables.size(),false);

        if(action.get_index()==5){
            int stop13 = 1;
        }
        int counter = 0;
        time_t join = clock();
        for (const auto &j : jt.get_order()) {
            ThesisSave join_save;
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
            int index_size = working_table.tuple_index.size();
            hash_join(working_table, tables[j.first], join_save);
            if(working_table.tuple_index.size()!=index_size){
                thesis_size_changed[j.second] = true;
            }

            // Project must be after removal of inequality constraints, otherwise we might keep only the
            // tuple violating some inequality. Variables in inequalities are also considered
            // distinguished.
           

            filter_static(action, working_table);
            project(working_table, project_over);
            if (working_table.tuples.empty()) {
                std::vector<ThesisSave> thesis_empty_joins;
                thesis_tables.at(action.get_index()) = std::move(thesis_empty_joins);
                return working_table;
            }
            if(thesis.is_enabled()){
                /*The full reducer changes the tables that represent static predicates a lot
                To circumvent this we carry over the unreduced hash-tables from the reducer
                We can look at the same positions as the first half of full-reducer steps is identical to the join steps
                */
                if(true) join_save.pos1_hashtable = thesis_semijoin.at(action.get_index()).at(counter).pos1_hashtable;
                if(true) join_save.pos2_hashtable = thesis_semijoin.at(action.get_index()).at(counter).pos2_hashtable;
                thesis_tables.at(action.get_index()).push_back(join_save);
            }
            counter++;
        }
        // For the case where the action schema is cyclic
        Table &working_table = tables[remaining_join[action.get_index()][0]];
        for (size_t i = 1; i < remaining_join[action.get_index()].size(); ++i) {
            ThesisSave join_save;
            hash_join(working_table, tables[remaining_join[action.get_index()][i]], join_save);
            filter_static(action, working_table);
            if (working_table.tuples.empty()) {
                //cout << " yann err3" << endl;
                return working_table;
            }
        }
        thesis.joinstep_time_normal += clock()-join;
        project(working_table, distinguished_variables[action.get_index()]);
        thesis.time_normal+= clock()- full_time;
        return working_table;
    }

    
}
