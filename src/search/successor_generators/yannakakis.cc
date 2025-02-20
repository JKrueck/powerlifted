
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

void YannakakisSuccessorGenerator::deal_with_add_semi(std::pair<int,int> &table_predicates, DynamicTables &save, DynamicTables &join_save, bool revert_join, std::unordered_set<GroundAtom,TupleHash> add_diff, bool first, int tab_id, bool call_on_add_eff, bool ugly_hack){
    int chem_counter = 0;
    GroundAtom last_insert;
    for(auto add:add_diff){
        //Generate the key for the newly added atom
        std::vector<int> key(save.matching_columns.size());
        for(size_t i = 0; i < save.matching_columns.size(); i++) {
           if(first){
                key[i] = add[save.matching_columns[i].first];
            }else{
                key[i] = add[save.matching_columns[i].second];
            }
        }

        if(first){
            //Insert the new atom into the pos1 hashtable
            if(save.pos2_hashtable.count(key)){
                save.pos1_hashtable[key].insert(add);
                save.result_table[key].insert(add);
                //Remember that we added this
                save.pos1_added.insert(add);

                bool skip = false;
                if(ugly_hack && add.size() == 2 && chem_counter % 2 !=0 && last_insert.size()!=0){
                    if(add.at(0) == last_insert.at(1) && add.at(1) == last_insert.at(0)) skip = true;
                }
                if(!skip){
                    if(!revert_join){
                        join_save.pos1_added.insert(add);
                        last_insert = add;
                    }else{
                        join_save.pos2_added.insert(add);
                        last_insert = add;
                    } 
                }
            }else if(!call_on_add_eff){
                //Catches the case that it was in the first Table in a prior iteration, but does not match to anything in this semijoin
                //This case can implicitely remove old adds without keeping track of it
                //Propably also matches cases where we want to add for the first time, but there is no match
                //Condition prevents this
                save.pos1_deleted.insert(add);
                if(!revert_join){
                    join_save.pos1_deleted.insert(add);
                    //Also remove it from the add list
                    join_save.pos1_added.erase(add);
                    if(ugly_hack){
                        GroundAtom copy = add;
                        std::reverse(copy.begin(),copy.end());
                        join_save.pos1_added.erase(copy);
                    } 
                    last_insert = add;
                } 
                else{
                    join_save.pos2_deleted.insert(add);
                    join_save.pos2_added.erase(add);
                    if(ugly_hack){
                        GroundAtom copy = add;
                        std::reverse(copy.begin(),copy.end());
                        join_save.pos2_added.erase(copy);
                    } 
                    last_insert = add;
                } 
            }
        }else{
            //Insert the new atom into the pos2 hashtable
            auto actually_added = save.pos2_hashtable[key].insert(add);
            if(actually_added.second){
                bool skip = false;
                if(ugly_hack && add.size()== 2&& chem_counter % 2 !=0 && last_insert.size()!=0){
                    if(add.at(0) == last_insert.at(1) && add.at(1) == last_insert.at(0)) skip = true;
                }
                if(!skip){
                    if(!revert_join){
                        join_save.pos2_added.insert(add);
                        last_insert = add;
                    }else{
                        join_save.pos1_added.insert(add);
                        last_insert = add;
                    } 
                }
                //If that key also exists in pos1 and not in the result yet, then the semi-join now is able to retain that key from pos1
                if(save.pos1_hashtable.count(key) && save.result_table.count(key)==0){
                    for(auto pos1:save.pos1_hashtable[key]){
                        save.result_table[key].insert(pos1);
                        //Remember that we added this here
                        save.pos1_added.insert(pos1);
                        if(!revert_join) join_save.pos1_added.insert(pos1);
                        else join_save.pos2_added.insert(pos1);
                    }
                }
            }
        }
        chem_counter++;
    }   
}
void YannakakisSuccessorGenerator::deal_with_del_semi(std::pair<int,int> &table_predicates, DynamicTables &save, DynamicTables &join_save, bool revert_join, std::unordered_set<GroundAtom,TupleHash> del_diff, bool first, int tab_id, bool ugly_hack){
    int chem_counter = 0;
    GroundAtom last_insert;
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
            bool skip = false;
            if(ugly_hack && del.size() == 2 && chem_counter % 2 !=0 && last_insert.size()!=0){
                if(del.at(0) == last_insert.at(1) && del.at(1) == last_insert.at(0)) skip = true;
            }
            
            //Remember that del has been deleted from this table
            save.pos1_deleted.insert(del);
            if(save.pos1_hashtable.count(key)!=0){


                //Remember about this fact for the JoinStep
                if(!skip){
                    if(!revert_join){
                        join_save.pos1_deleted.insert(del);
                        join_save.pos1_added.erase(del);
                        last_insert = del;
                    }else{
                        join_save.pos2_deleted.insert(del);
                        join_save.pos2_added.erase(del);
                        last_insert = del;
                    } 
                }

                //As the element at save_obj.pos1_hashtable.at(key) is a unordered_set, this takes constant time on average
                auto pos = save.pos1_hashtable.at(key).find(del);
                if(pos!=save.pos1_hashtable.at(key).end()){//
                    save.pos1_hashtable.at(key).erase(pos);
                
                    
                    
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
            bool skip = false;
            if(ugly_hack && del.size() == 2 && chem_counter % 2 !=0 && last_insert.size()!=0){
                if(del.at(0) == last_insert.at(1) && del.at(1) == last_insert.at(0)) skip = true;
            }
            if(!skip){
                if(!revert_join){
                    join_save.pos2_deleted.insert(del);
                    join_save.pos2_added.erase(del);
                    last_insert = del;
                }else{
                    join_save.pos1_deleted.insert(del);
                    join_save.pos1_added.erase(del);
                    last_insert = del;
                } 
            }
            save.pos2_deleted.insert(del);
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
                                if(!revert_join){
                                    join_save.pos1_deleted.insert(it);
                                    join_save.pos1_added.erase(it);
                                }else{
                                    join_save.pos2_deleted.insert(it);
                                    join_save.pos2_added.erase(it);
                                } 
                            }
                            save.result_table.erase(key);
                        }
                    }
                }
            }
        }
        chem_counter++;
    }

}
void YannakakisSuccessorGenerator::deal_with_add_full(std::pair<int,int> &table_predicates, DynamicTables &save, std::unordered_set<GroundAtom,TupleHash> add_diff, bool first, int index_size){
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
            if(save.pos2_hashtable.count(key)!=0){
                //Insert the new atom into the pos1 hashtable
                save.pos1_hashtable[key].insert(it);
                //unnessescary??Still not sure if changing the for each element changes the real one
                /*Go trough all entries in the second pos table that match the new one
                Add the corresponding elements from the second table to our new atom
                */
                std::unordered_set<GroundAtom, TupleHash> to_add = save.pos2_hashtable[key];
                for(auto tup:to_add){
                    auto copy = it;
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
            if(true){//save.pos2_hashtable[key].find(it)==save.pos2_hashtable[key].end()
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
void YannakakisSuccessorGenerator::deal_with_del_full(std::pair<int,int> &table_predicates, DynamicTables &save, std::unordered_set<GroundAtom,TupleHash> del_diff, bool first, int index_size){
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
                        //save.pos1_hashtable.at(key).erase(pos);
                        //Remember that del has been deleted from this table
                        save.pos1_deleted.insert(del);
                        
                        //If the set has no entries left after removal, we can delete that key
                        //This also means that there is no match between pos1 and pos2 on that key
                        //If that key appears in the result it can thus be deleted
                        if(save.pos1_hashtable.at(key).size()==0){//
                            save.pos1_hashtable.erase(key);
                            if(save.result_table.count(key)!=0){
                                for(auto it:save.result_table[key]){
                                    save.result_deleted.insert(it);
                                }
                                save.result_table.erase(key);
                            }
                        //If the set is not empty but the key does not appear in the pos2 hashtable, we can delete that key in the result too
                        }else if(save.pos2_hashtable.count(key)==0){
                            for(auto it:save.result_table[key]){
                                save.result_deleted.insert(it);
                            }
                            save.result_table.erase(key);
                        }else{//If there are still entries for that key in both tables, we need to remove the results that match the removed element
                            //Generate the atoms that wont exist anymore and then erase them
                            std::unordered_set<GroundAtom, TupleHash> to_add = save.pos2_hashtable[key];
                            for(auto tup:to_add){
                                auto copy = del;
                                for (unsigned j = 0; j < to_remove_me.size(); ++j) {
                                    if (!to_remove_me[j]) copy.push_back(tup[j]);
                                }
                                save.result_table[key].erase(copy);
                                save.result_deleted.insert(copy);
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
                    //If the set is not empty but the key does not appear in the pos2 hashtable, we can delete that key in the result too
                    else if(save.pos2_hashtable.count(key)==0){
                        for(auto it:save.result_table[key]){
                            save.result_deleted.insert(it);
                        }
                        save.result_table.erase(key);
                    }else{//If there are still entries for that key in both tables, we need to remove the results that match the removed element
                        //Generate the atoms that wont exist anymore and then erase them
                        for(auto test:save.pos1_hashtable[key]){
                            auto copy = test;
                            GroundAtom to_add = del;
                            for (unsigned j = 0; j < to_remove_me.size(); ++j) {
                                if (!to_remove_me[j]) copy.push_back(to_add[j]);
                            }
                            save.result_table[key].erase(copy);
                            save.result_deleted.insert(copy);
                        }
                        //Hope this case is infrequent
                    }
                }
            }
        }
    }

}

void YannakakisSuccessorGenerator::determine_changes_crossProduct(DynamicTables& save, Table& old_tab, Table& new_tab){
    std::vector<bool> old_found(old_tab.tuples.size(), false);
    std::unordered_set<GroundAtom,TupleHash> old;
    //For every entry in the new table, check if that entry already exists in the old table
    //If not, it has been added
    for(auto new_entry:new_tab.tuples){
        bool new_found = false;
        std::size_t hash = boost::hash_range(new_entry.begin(),new_entry.end());
        int counter = 0;
        for(auto old_entry:old_tab.tuples){
            if(hash == boost::hash_range(old_entry.begin(),old_entry.end())){
                //Mark that this entry exists in both the old and new tables
                old_found.at(counter) = true;
                new_found = true;
                break;
            }
            counter++;
        }
        if(!new_found) save.pos1_added.insert(new_entry);
    }
    int counter = 0;
    //All entries in the old table that were not found, were deleted
    for(auto it:old_found){
        if(!it) save.result_deleted_single.insert(old_tab.tuples.at(counter));
        counter++;
    }
}

void YannakakisSuccessorGenerator::thesis_filter_static(const ActionSchema &action, GroundAtom &check, DynamicTables &save){
    const auto& tup_idx = save.result_index;

    for (const Atom& atom : save.static_pre_deletes) {
        const std::vector<Argument> &args = atom.get_arguments();
        bool is_equality = true;
        // TODO: for now, we assume all static preconditions are
        //       (in)equalities. This may change in future
        if (is_equality){
            assert(args.size() == 2);
            if (args[0].is_constant() && args[1].is_constant()){
                bool is_equal = (args[0].get_index() == args[1].get_index());

                if ((atom.is_negated() && is_equal)
                        || (!atom.is_negated() && !is_equal)){
                    check.clear();
                    return;
                }

            }else if (args[0].is_constant() || args[1].is_constant()){
                int param_idx = -1;
                int const_idx = -1;
                if (args[0].is_constant()){
                    const_idx = args[0].get_index();
                    param_idx = args[1].get_index();
                }else{
                    const_idx = args[1].get_index();
                    param_idx = args[0].get_index();
                }
                auto it = find(tup_idx.begin(), tup_idx.end(), param_idx);
                if (it != tup_idx.end()){
                    int index = distance(tup_idx.begin(), it);

                    if (!((atom.is_negated() && check[index] != const_idx)
                            || (!atom.is_negated() && check[index] == const_idx))){

                        check.clear();
                        return;
                    }
                }

            }else{ // !args[0].is_constant() && !args[1].is_constant()
                // TODO Revise this, looks that some work could be offloaded to preprocessing so that we
                //      do not need to do all this linear-time finds at runtime?
                auto it_1 = find(tup_idx.begin(), tup_idx.end(), args[0].get_index());
                auto it_2 = find(tup_idx.begin(), tup_idx.end(), args[1].get_index());

                if (it_1 != tup_idx.end() and it_2 != tup_idx.end()) {
                    int index1 = distance(tup_idx.begin(), it_1);
                    int index2 = distance(tup_idx.begin(), it_2);

                    if (!((atom.is_negated() && check[index1] != check[index2])
                            || (!atom.is_negated() && check[index1] == check[index2]))){
                        check.clear();
                        return;
                    }
                }
            }
        }

    }
}

Table YannakakisSuccessorGenerator::dynamic_instantiate(const ActionSchema &action,const DBState &state,const Task &task, DynamicState &thesis,
                            std::vector<std::vector<DynamicTables>> &thesis_tables, std::vector<std::vector<DynamicTables>> &dynamic_semijoin, DBState &old_state)
{
    //cout << "used" << endl;
    thesis.counter_me++;
    const auto dynamic_timer  = std::chrono::high_resolution_clock::now();
    std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> predicate_to_add_diff = thesis.get_add_effect_map();
    std::unordered_map<int,bool>  diff_delete = thesis.get_del_eff();

    const JoinTree &jt = join_trees[action.get_index()];
   
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

    const auto &actiondata = action_data[action.get_index()];
    vector<Table> tables;
    auto res = parse_precond_into_join_program(actiondata, state, tables);
    if (!res){
        //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
        //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
        std::vector<DynamicTables> thesis_empty_joins;
        dynamic_semijoin.at(action.get_index()) = std::move(thesis_empty_joins);
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
    std::pair<int,int> table_predicates;


    std::unordered_map<int, std::unordered_set<GroundAtom, TupleHash>> table_delete_list;

    //The organic synthesis domain contains double facts - modeling a bond in both directions
    //These double facts somehow still cause problems
    bool extreme_hack_flag;
    if(std::strcmp(task.get_domain_name().c_str(),"chemical") == 0) extreme_hack_flag = false;

    const auto full_reducer = std::chrono::high_resolution_clock::now();
    long unsigned int counter = 0;
    for (const pair<int, int> &sj : full_reducer_order[action.get_index()]) {  
        table_predicates.first = action.get_precondition().at(sj.first).get_predicate_symbol_idx();
        table_predicates.second = action.get_precondition().at(sj.second).get_predicate_symbol_idx();

        //If there is a change in the computation of this semi-join   
        if((compute_semi_join.at(sj.first) || compute_semi_join.at(sj.second)) && (affected_tables.count(sj.first)==0 && affected_tables.count(sj.second)==0)){
            //If that change is(are) only a newly added atom(s) 
            if((thesis_affected_by_del.count(sj.second) == 0 && thesis_affected_by_del.count(sj.first) == 0) || thesis_affected_by_del.size() ==0){
                //Get the new structure
                DynamicTables &save_obj = dynamic_semijoin.at(action.get_index()).at(counter);
                auto remember = save_obj.pos1_hashtable;
                int join_elem;
                bool revert_join = false;

                if(counter<(full_reducer_order[action.get_index()].size()/2)) join_elem = counter;
                else{
                    join_elem = full_reducer_order[action.get_index()].size()/2- (counter - full_reducer_order[action.get_index()].size()/2+1);
                    revert_join = true;
                }

                if(predicate_to_add_diff.count(table_predicates.first)!=0){

                    deal_with_add_semi(table_predicates,save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, predicate_to_add_diff.at(table_predicates.first),false,sj.first, true, extreme_hack_flag);

                }
                if(predicate_to_add_diff.count(table_predicates.second)!=0){
                    
                    deal_with_add_semi(table_predicates,save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, predicate_to_add_diff.at(table_predicates.second),true, sj.second, true, extreme_hack_flag);
                
                }

                //Generate the WHOLE complete new_table
                //Unnessescary probably
                tables[sj.second] = save_obj.generate_table();
                affected_tables.insert_or_assign(sj.second,counter);
            }else{
                //If that change was a delete effect (and maybe also add effect)
                //Get the new structure
                DynamicTables &save_obj = dynamic_semijoin.at(action.get_index()).at(counter);
                auto remember = save_obj.pos1_hashtable;
                std::unordered_set<GroundAtom, TupleHash> save;
                int join_elem;
                bool revert_join = false;

                if(counter<(full_reducer_order[action.get_index()].size()/2)) join_elem = counter;
                else{
                    join_elem = full_reducer_order[action.get_index()].size()/2- (counter - full_reducer_order[action.get_index()].size()/2+1);
                    revert_join = true;
                } 
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
                    //Remember that the table at the second position was affected by a del effecy
                    affected_tables.insert_or_assign(sj.second,counter);
                }
                    


                //Firstly deal with any possible add-effects
                if(predicate_to_add_diff.count(table_predicates.first)!=0) deal_with_add_semi(table_predicates,save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, predicate_to_add_diff.at(table_predicates.first),false, sj.first, true,extreme_hack_flag);
                if(predicate_to_add_diff.count(table_predicates.second)!=0) deal_with_add_semi(table_predicates,save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, predicate_to_add_diff.at(table_predicates.second),true, sj.second, true, extreme_hack_flag);
                //Now deal with deletes
                if(delete_condition1) deal_with_del_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, deleted_first,false, sj.first, extreme_hack_flag);
                if(delete_condition2) deal_with_del_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, deleted_second, true, sj.second, extreme_hack_flag);

                
                //Generate the WHOLE complete new_table
                //Unnessescary probably
                tables[sj.second] = save_obj.generate_table();
                
                //If the resulting semi-join was empty
                if(tables[sj.second].tuples.size()==0){
                    //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                    //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                    std::vector<DynamicTables> thesis_empty_semijoins;
                    dynamic_semijoin.at(action.get_index()) = std::move(thesis_empty_semijoins);
                    return Table::EMPTY_TABLE();
                }
            }
        }else if(affected_tables.count(sj.first)!=0 && affected_tables.count(sj.second) == 0 ){
            //This is very similar to just computing a new semi-join --- talk about this
            //For this direction its probably easier to just compute the semi-join ?
            //Get the new structure
            DynamicTables &save_obj = dynamic_semijoin.at(action.get_index()).at(counter);
            DynamicTables &old_save = dynamic_semijoin.at(action.get_index()).at(affected_tables[sj.first]);
            std::unordered_set<GroundAtom, TupleHash> save;
            int join_elem;
            bool revert_join = false;

            if(counter<(full_reducer_order[action.get_index()].size()/2)) join_elem = counter;
            else{
                join_elem = full_reducer_order[action.get_index()].size()/2- (counter - full_reducer_order[action.get_index()].size()/2+1);
                revert_join = true;
            } 
            if(save_obj.matching_columns.size()==0){

                semi_join(tables[sj.second],tables[sj.first],save_obj);

            }else{
                
                deal_with_add_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, old_save.pos1_added, false, sj.first, false, extreme_hack_flag);
                deal_with_del_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, old_save.pos1_deleted,false, sj.first,extreme_hack_flag);
                
                //It can happen that there are still changes that need to be made to the second table
                if(compute_semi_join[sj.second]){
                    std::unordered_set<GroundAtom, TupleHash> deleted_second;
                    bool delete_condition2 = false;
                    if(thesis_affected_by_del.count(sj.second)!=0){
                        deleted_second = thesis.deleted_facts.at(thesis_affected_by_del.at(sj.second));
                        delete_condition2 = true;
                        affected_tables.insert_or_assign(sj.second,counter);
                    }
                    if(predicate_to_add_diff.count(action.get_precondition().at(sj.second).get_predicate_symbol_idx())!=0) deal_with_add_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, predicate_to_add_diff.at(table_predicates.second), true, sj.second, false, extreme_hack_flag);
                    if(delete_condition2) deal_with_del_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, deleted_second, true, sj.second, extreme_hack_flag);
                }

                tables[sj.second] = save_obj.generate_table();
            }
            //If the resulting semi-join was empty
            if(tables[sj.second].tuples.size()==0){
                //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                std::vector<DynamicTables> thesis_empty_semijoins;
                dynamic_semijoin.at(action.get_index()) = std::move(thesis_empty_semijoins);
                return Table::EMPTY_TABLE();
            }
            
            affected_tables.insert_or_assign(sj.second,counter);
        }else if(affected_tables.count(sj.second)!=0 && affected_tables.count(sj.first) == 0){
            /*
            What if both tables have changed????
            For now do a full semi-join between them
            */
            //Get the new structure
            DynamicTables &save_obj = dynamic_semijoin.at(action.get_index()).at(counter);
            DynamicTables &old_save = dynamic_semijoin.at(action.get_index()).at(affected_tables[sj.second]);
            auto remember = save_obj.pos1_hashtable;
            std::unordered_set<GroundAtom, TupleHash> save;
            int join_elem;
            bool revert_join = false;

            if(counter<(full_reducer_order[action.get_index()].size()/2)) join_elem = counter;
            else{
                join_elem = full_reducer_order[action.get_index()].size()/2- (counter - full_reducer_order[action.get_index()].size()/2+1);
                revert_join = true;
            } 
            //There are some cases in which the semi-join in the initial state was interrupted due to there being no matching columns
            //If that was the case we need to do a full semi-join
            //See comments above
            if(save_obj.matching_columns.size()==0){
                semi_join(tables[sj.second],tables[sj.first],save_obj);
                save_obj.pos1_added = old_save.pos1_added;
                save_obj.pos1_deleted = old_save.pos1_deleted;
            }else{

                deal_with_add_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, old_save.pos1_added, true, sj.second, false, extreme_hack_flag);
                deal_with_del_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, old_save.pos1_deleted, true, sj.second,extreme_hack_flag);

                tables[sj.second] = save_obj.generate_table();
            }
            //If the resulting semi-join was empty
            if(tables[sj.second].tuples.size()==0){
                //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                std::vector<DynamicTables> thesis_empty_semijoins;
                //cout << "err2" << endl;
                dynamic_semijoin.at(action.get_index()) = std::move(thesis_empty_semijoins);
                return Table::EMPTY_TABLE();
            }
            if(save_obj.pos1_added.size()!=0 || save_obj.pos1_deleted.size()!=0) affected_tables.insert_or_assign(sj.second,counter);
        }else if(affected_tables.count(sj.first)!=0 && affected_tables.count(sj.second)!=0){
            //Get the new structure
            DynamicTables &save_obj = dynamic_semijoin.at(action.get_index()).at(counter);
            //Get the old structures
            DynamicTables &old_save_pos1 = dynamic_semijoin.at(action.get_index()).at(affected_tables[sj.second]);
            DynamicTables &old_save_pos2 = dynamic_semijoin.at(action.get_index()).at(affected_tables[sj.first]);
            std::unordered_set<GroundAtom, TupleHash> save;
            int join_elem;
            bool revert_join = false;

            if(counter<(full_reducer_order[action.get_index()].size()/2)) join_elem = counter;
            else{
                join_elem = full_reducer_order[action.get_index()].size()/2- (counter - full_reducer_order[action.get_index()].size()/2+1);
                revert_join = true;
            } 
            auto remember = save_obj.pos1_hashtable;
            if(save_obj.matching_columns.size()==0){
                semi_join(tables[sj.second],tables[sj.first],save_obj);
                save_obj.pos1_added = old_save_pos1.pos1_added;
                save_obj.pos1_deleted = old_save_pos1.pos1_deleted;
            }else{
                
                //Order tab2 before tab1 important
                deal_with_add_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, old_save_pos2.pos1_added, false, sj.first, false, extreme_hack_flag);
                deal_with_add_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, old_save_pos1.pos1_added, true, sj.second, false,extreme_hack_flag);
    
                
                deal_with_del_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, old_save_pos1.pos1_deleted, true,  sj.second, extreme_hack_flag);
                deal_with_del_semi(table_predicates, save_obj, thesis_tables.at(action.get_index()).at(join_elem), revert_join, old_save_pos2.pos1_deleted,false, sj.first,extreme_hack_flag);

                tables[sj.second] = save_obj.generate_table();
            }
            if(tables[sj.second].tuples.size()==0){
                //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                std::vector<DynamicTables> thesis_empty_semijoins;
                dynamic_semijoin.at(action.get_index()) = std::move(thesis_empty_semijoins);
                return Table::EMPTY_TABLE();
            }
            affected_tables.insert_or_assign(sj.second,counter);
        }else{
            tables[sj.second] = dynamic_semijoin.at(action.get_index()).at(counter).result;
            tables[sj.second].tuple_index = dynamic_semijoin.at(action.get_index()).at(counter).result_index;
        }
        counter++;
    }

    //We have stored everything that was deleted/added to some table
    //If this storage isn´t cleared we will continue to add/delete these atoms in future states as the data structures are carried over betweens states 
    for(long unsigned int i=0;i<dynamic_semijoin.at(action.get_index()).size();i++){
        dynamic_semijoin.at(action.get_index()).at(i).refresh_tables();
    }
    affected_tables.clear();

    double iteration_time = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::high_resolution_clock::now() - full_reducer).count();
    thesis.fullreducer_time_me+= iteration_time;
    if(iteration_time>thesis.max_fullreducer_me) thesis.max_fullreducer_me = iteration_time;
    if(iteration_time<thesis.min_fullreducer_me) thesis.min_fullreducer_me = iteration_time;
    

    const auto join = std::chrono::high_resolution_clock::now();

    std::unordered_map<int,std::unordered_set<GroundAtom, TupleHash>> added_to_table;
    std::unordered_map<int,std::unordered_set<GroundAtom, TupleHash>> deleted_from_table;
    
    counter = 0;
    for (const auto &j : jt.get_order()) {
        //Get the new structure
        DynamicTables &save_obj = thesis_tables.at(action.get_index()).at(counter);
        if(save_obj.pos1_added.size()!=0 || save_obj.pos1_deleted.size()!=0 || save_obj.pos2_added.size()!=0 || save_obj.pos2_deleted.size()!=0 ||  deleted_from_table.count(j.first)!=0 || deleted_from_table.count(j.second)!=0 || added_to_table.count(j.first)!=0 || added_to_table.count(j.second)!=0 || affected_tables.count(j.first)!=0 || affected_tables.count(j.second)!=0){
            DynamicTables old_pos1;
            DynamicTables old_pos2;
            if (affected_tables.count(j.second)!=0)  old_pos1 = thesis_tables.at(action.get_index()).at(affected_tables[j.second]);
            if (affected_tables.count(j.first)!=0)   old_pos2 = thesis_tables.at(action.get_index()).at(affected_tables[j.first]);

            //If we add stuff to the added table during the iteration, then the other add thing will grab that
            //This will treat an atom that was just added this iteration as a old result and the resulting join will be very wrong  
            std::unordered_set<GroundAtom, TupleHash> iteration_add_storage;

            unordered_set<int> project_over;
            for (auto x : tables[j.second].tuple_index) {
                project_over.insert(x);
            }
            for (auto x : tables[j.first].tuple_index) {
                if (distinguished_variables[action.get_index()].count(x) > 0) {
                    project_over.insert(x);
                }
            }
            
            
            //Do the Cross Product
            if(save_obj.matching_columns.size()==0){
                const auto cross_product = std::chrono::high_resolution_clock::now();
                auto remember = save_obj.result;

                Table &working_table = tables[j.second];
                hash_join(working_table, tables[j.first]);
                filter_static(action, working_table, save_obj);
                project(working_table, project_over, save_obj, thesis.old_indices.at(action.get_index()).at(j.second).size());

                save_obj.result = working_table;

                determine_changes_crossProduct(save_obj, remember, save_obj.result);
                added_to_table[j.second].insert(save_obj.pos1_added.begin(),save_obj.pos1_added.end());
                save_obj.pos1_added.clear();
                
                affected_tables[j.second] = counter;
                counter++;

                iteration_time = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::high_resolution_clock::now() - cross_product).count();
                thesis.crossproduct_time += iteration_time;
                continue;
            }

            //If filter_static removes some elements
            for(auto del:save_obj.result_deleted_static){
                //Generate the JoinStep Key for that statically removed element
                std::vector<int> join_step_key(thesis.old_indices.at(action.get_index()).at(j.second).size());
                for(size_t pos = 0; pos < thesis.old_indices.at(action.get_index()).at(j.second).size(); pos++){
                    join_step_key[pos] = del[pos];
                }
                //If the statically removed element exists in the current result...
                if(save_obj.result_table.count(join_step_key)!=0){
                    //...find it and...
                    auto pos = save_obj.result_table[join_step_key].find(del);
                    if(pos!=save_obj.result_table[join_step_key].end()){
                        //...delete it
                        save_obj.result_table[join_step_key].erase(pos);
                        save_obj.result_deleted_single.insert(del);
                        if(save_obj.result_table[join_step_key].size()==0) save_obj.result_table.erase(join_step_key);
                    }
                }
            }

            //If the size of the first table has NOT changed in comparison to the SemiJoin Results
            //-> we can use the normal semijoin keys here
            if(!save_obj.join_changed_size_first){
                //Check all facts that were deleted from table 1
                for(auto del:save_obj.pos1_deleted){
                    //Generate the SemiJoin key for the deleted fact
                    std::vector<int> key(save_obj.matching_columns.size());
                    for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                        key[pos] = del[save_obj.matching_columns[pos].first];
                    }

                    //Create a reverse key for chem domain
                    std::vector<int> key_hack(save_obj.matching_columns.size());
                    GroundAtom copy;
                    //If we are in the chem domain
                    if(extreme_hack_flag){
                        //create a copy of the deleted fact
                        copy = del;
                        //reverse the object order of the copy
                        std::reverse(copy.begin(),copy.end());
                        //Create a reverse JoinStep key based on the matching columns of the join
                        for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                            key_hack[pos] = copy[save_obj.matching_columns[pos].first];
                        }
                    }

                    //If the deleted fact is in table 1...
                    if(save_obj.pos1_hashtable.count(key)!=0){
                        //..find it and delete it
                        auto pos = save_obj.pos1_hashtable[key].find(del);
                        if(pos!=save_obj.pos1_hashtable[key].end()) save_obj.pos1_hashtable[key].erase(pos);
                        if(save_obj.pos1_hashtable[key].size()==0) save_obj.pos1_hashtable.erase(key);
                    }

                    //If the reverse key is here find and delete it
                    if(extreme_hack_flag && save_obj.pos1_hashtable.count(key_hack)!=0){
                        auto pos = save_obj.pos1_hashtable[key_hack].find(copy);
                        if(pos!=save_obj.pos1_hashtable[key_hack].end()) save_obj.pos1_hashtable[key_hack].erase(pos);
                        if(save_obj.pos1_hashtable[key_hack].size()==0) save_obj.pos1_hashtable.erase(key_hack);
                    }

                    //If it is in the result find and delete it
                    if(save_obj.result_table.count(del)!=0){
                        save_obj.result_deleted.insert(del);
                        //Save that a single fact was deleted
                        save_obj.result_deleted_single.insert(save_obj.result_table[del].begin(),save_obj.result_table[del].end());
                        save_obj.result_table.erase(del);
                        deleted_from_table[j.second].insert(del);
                    }

                    //Same but with the reversed key
                    if(extreme_hack_flag && save_obj.result_table.count(copy)!=0){
                        save_obj.result_deleted.insert(copy);
                        save_obj.result_deleted_single.insert(save_obj.result_table[copy].begin(),save_obj.result_table[copy].end());
                        save_obj.result_table.erase(copy);
                        deleted_from_table[j.second].insert(copy);
                    }
                }
            }

            //If the size of the first table HAS changed in comparison to the SemiJoin Results
            //->need to use the JoinStep keys ??? or not????
            if(save_obj.join_changed_size_first){
                //Go through all previously deleted elements 
                for(auto del:deleted_from_table[j.second]){
                    GroundAtom copy;
                    if(save_obj.result_table.count(del)!=0){
                        std::vector<int> key(save_obj.matching_columns.size());
                        for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                            key[pos] = save_obj.result_table[del].begin()->at(save_obj.matching_columns[pos].first);
                        }
                        if(save_obj.pos1_hashtable.count(key)!=0){
                            save_obj.pos1_hashtable.erase(key);
                            save_obj.result_deleted.insert(del);
                            save_obj.result_deleted_single.insert(save_obj.result_table[del].begin(),save_obj.result_table[del].end());
                            save_obj.result_table.erase(del);
                            deleted_from_table[j.second].insert(del);
                        }
                    }
                    if(extreme_hack_flag){
                        std::reverse(copy.begin(),copy.end());
                        if(save_obj.result_table.count(copy)!=0){
                            std::vector<int> key(save_obj.matching_columns.size());
                            for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                                key[pos] = save_obj.result_table[copy].begin()->at(save_obj.matching_columns[pos].first);
                            }
                            if(save_obj.pos1_hashtable.count(key)!=0){
                                save_obj.pos1_hashtable.erase(key);
                                save_obj.result_deleted.insert(copy);
                                save_obj.result_deleted_single.insert(save_obj.result_table[copy].begin(),save_obj.result_table[copy].end());
                                save_obj.result_table.erase(copy);
                                deleted_from_table[j.second].insert(copy);
                            }
                        }
                    }
                }

                //If the first table has been affected by the state transition
                if(affected_tables.count(j.second)!=0){
                    //Check all facts we deleted in this join in the parent state
                    for(auto del:old_pos1.result_deleted_single){
                        GroundAtom copy;
                        //If the join result gets bigger, we need to compute the element we want to remove
                        std::vector<int> key(save_obj.matching_columns.size());
                        std::vector<int> key_hack(save_obj.matching_columns.size());
                        for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                            key[pos] = del[save_obj.matching_columns[pos].first];
                        }
                        if(extreme_hack_flag){
                            copy = del;
                            std::reverse(copy.begin(),copy.end());
                            for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                                key_hack[pos] = copy[save_obj.matching_columns[pos].first];
                            }
                        }
                        if(save_obj.pos1_hashtable.count(key)!=0){
                            auto pos = save_obj.pos1_hashtable[key].find(del);
                            if(pos!=save_obj.pos1_hashtable[key].end()){
                                save_obj.pos1_hashtable[key].erase(pos);
                                //save_obj.result_deleted_single.insert(del);
                                if(save_obj.pos1_hashtable[key].size()==0) save_obj.pos1_hashtable.erase(key);
                            }
                        }
                        if(extreme_hack_flag && save_obj.pos1_hashtable.count(key_hack)!=0){
                            auto pos = save_obj.pos1_hashtable[key_hack].find(copy);
                            if(pos!=save_obj.pos1_hashtable[key_hack].end()) save_obj.pos1_hashtable[key_hack].erase(pos);
                            if(save_obj.pos1_hashtable[key_hack].size()==0) save_obj.pos1_hashtable.erase(key_hack);
                        }

                        //???What does this mean??Here we seem to start with a element that could have the wrong size and compute the needed join to find the element that should be deleted
                        //If the deleted fact also shows up in Table 2
                        if(save_obj.pos2_hashtable.count(key)!=0){
                            std::unordered_set<GroundAtom, TupleHash> to_change = save_obj.pos2_hashtable[key];
                            std::vector<bool> to_remove_me(tables[j.first].tuple_index.size(), false);
                            for (const auto &m : save_obj.matching_columns) {
                                to_remove_me[m.second] = true;
                            }
                            for(auto tup:to_change){
                                auto copy = del;
                                for (unsigned pos = 0; pos < to_remove_me.size(); ++pos) {
                                    if (!to_remove_me[pos]) copy.push_back(tup[pos]);
                                }
                                std::vector<int> join_step_key(thesis.old_indices.at(action.get_index()).at(j.second).size());
                                for(size_t pos = 0; pos < thesis.old_indices.at(action.get_index()).at(j.second).size(); pos++){
                                    join_step_key[pos] = copy[pos];
                                }
                                auto pos = save_obj.result_table[join_step_key].find(copy);
                                if(pos!=save_obj.result_table[join_step_key].end()){
                                    save_obj.result_table[join_step_key].erase(copy);
                                    save_obj.result_deleted_single.insert(copy);
                                }
                                if(save_obj.result_table[join_step_key].size()==0) save_obj.result_table.erase(join_step_key);
                            }
                        }
                    }

                    //Delete entire keys
                    for(auto del:old_pos1.result_deleted){
                        if(save_obj.result_table.count(del)!=0){
                            save_obj.result_deleted.insert(del);
                            save_obj.result_table.erase(del);
                            deleted_from_table[j.second].insert(del);
                        }
                    }
                }
                
            }

            //If the second table does not change its attribute size  with the current join
            if(!save_obj.join_changed_size_second){
                //For all facts deleted from table 2
                for(auto del:save_obj.pos2_deleted){
                    //Generate the key for the deleted fact
                    std::vector<int> key(save_obj.matching_columns.size());
                    for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                        key[pos] = del[save_obj.matching_columns[pos].second];
                    }

                    //Generate the key for the reversed fact
                    std::vector<int> key_hack(save_obj.matching_columns.size());
                    GroundAtom copy;
                    if(extreme_hack_flag){
                        copy = del;
                        std::reverse(copy.begin(),copy.end());
                        for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                            key_hack[pos] = copy[save_obj.matching_columns[pos].second];
                        }
                    }

                    //If that key for the deleted fact occurs in table 2
                    if(save_obj.pos2_hashtable.count(key)!=0){
                        int size1,size2;

                        //If the key has a match in Table1 set size1 to the amount of facts in Table1 that have that key
                        if(save_obj.pos1_hashtable.count(key)!=0) size1 = save_obj.pos1_hashtable[key].size();
                        else size1 = 0;

                        //Check whether the deleted fact occurs in Table2
                        auto pos = save_obj.pos2_hashtable[key].find(del);
                        //Pretty unnesecary
                        //If the key has a match in Table2 set size2 to the amount of facts in Table2 that have that key
                        if(save_obj.pos2_hashtable.count(key)!=0) size2 = save_obj.pos2_hashtable[key].size();
                        else size2 = 0;

                        //If the deleted fact occurs in Table2, erase it 
                        if(pos!=save_obj.pos2_hashtable[key].end()) save_obj.pos2_hashtable[key].erase(del);
                        
                        //If that was the only fact of this key, delete the key
                        if(save_obj.pos2_hashtable[key].size()==0) save_obj.pos2_hashtable.erase(key);
                        
                        //If there is more than one entry that matches this key in Table1, then we can´t just delete the result key
                        //This would also delete the legitimate join results of the other entries in pos2
                        if(save_obj.pos1_hashtable.count(key)!=0 && size1==1 && size2==1){
                            auto check = save_obj.pos1_hashtable[key];
                            for(auto del:check){
                                std::vector<int> join_step_key(thesis.old_indices.at(action.get_index()).at(j.second).size());
                                for(size_t pos = 0; pos < thesis.old_indices.at(action.get_index()).at(j.second).size(); pos++){
                                    join_step_key[pos] = del[pos];
                                }
                                if(save_obj.result_table.count(join_step_key)!=0){
                                    save_obj.result_deleted_single.insert(save_obj.result_table[join_step_key].begin(),save_obj.result_table[join_step_key].end());
                                    save_obj.result_table.erase(join_step_key);
                                    deleted_from_table[j.second].insert(join_step_key);
                                }
                            }
                        }else{
                            if(size1==0 && size2==0) continue;
                            //Compute the join results between the deleted fact from Table2 and its matches in Table1 
                            //Delete it if it appears in the result
                            std::vector<bool> to_remove_me(tables[j.first].tuple_index.size(), false);
                            for (const auto &m : save_obj.matching_columns) {
                                to_remove_me[m.second] = true;
                            }
                            std::unordered_set<GroundAtom, TupleHash> to_change = save_obj.pos1_hashtable[key];
                            for(auto tup:to_change){
                                for (unsigned pos = 0; pos < to_remove_me.size(); ++pos) {
                                    if (!to_remove_me[pos]) tup.push_back(del[pos]);
                                }
                                std::vector<int> join_step_key(thesis.old_indices.at(action.get_index()).at(j.second).size());
                                for(size_t pos = 0; pos < thesis.old_indices.at(action.get_index()).at(j.second).size(); pos++){
                                    join_step_key[pos] = tup[pos];
                                }
                                auto pos = save_obj.result_table[join_step_key].find(tup);
                                if(pos!=save_obj.result_table[join_step_key].end()){
                                    save_obj.result_table[join_step_key].erase(tup);
                                    save_obj.result_deleted_single.insert(tup);
                                }
                                if(save_obj.result_table[join_step_key].size()==0) save_obj.result_table.erase(join_step_key);
                            }
                        } 
                    }

                    //Same as above but with the key for the reversed fact
                    if(extreme_hack_flag && save_obj.pos2_hashtable.count(key_hack)!=0){
                        int size1,size2;
                        if(save_obj.pos1_hashtable.count(key_hack)!=0) size1 = save_obj.pos1_hashtable[key_hack].size();
                        else size1 = 0;

                        auto pos = save_obj.pos2_hashtable[key_hack].find(copy);
                        if(save_obj.pos2_hashtable.count(key_hack)!=0) size2 = save_obj.pos2_hashtable[key_hack].size();
                        else size2 = 0;

                        if(pos!=save_obj.pos2_hashtable[key_hack].end()) save_obj.pos2_hashtable[key_hack].erase(copy);
                        
                        if(save_obj.pos2_hashtable[key_hack].size()==0) save_obj.pos2_hashtable.erase(key_hack);
                        
                        //If there is more than one entry that matches this key in pos1, then we can´t just delete the result key
                        //This would also delete the legitimate join results of the other entries in pos2
                        if(save_obj.pos1_hashtable.count(key_hack)!=0 && size1==1 && size2==1){
                            auto check = save_obj.pos1_hashtable[key_hack];
                            for(auto del:check){//hfhfgh
                                std::vector<int> join_step_key(thesis.old_indices.at(action.get_index()).at(j.second).size());
                                for(size_t pos = 0; pos < thesis.old_indices.at(action.get_index()).at(j.second).size(); pos++){
                                    join_step_key[pos] = del[pos];
                                }
                                if(save_obj.result_table.count(join_step_key)!=0){
                                    save_obj.result_deleted_single.insert(save_obj.result_table[join_step_key].begin(),save_obj.result_table[join_step_key].end());
                                    save_obj.result_table.erase(join_step_key);
                                    deleted_from_table[j.second].insert(join_step_key);
                                }
                            }
                        //Instead we need to find the exact result and delete it
                        //This means we need to expensively pre-calculate the join
                        //I dont want this
                        /*
                        Checking every element for the positions of the deleted element takes time linear in the size of that hash-bucket
                        vs.
                        size(pos1_hashtable[key]) * size(matchting_columns) * size of elements in hashtable
                        I think option one should typically be faster?? Depends on the size of the result bin
                        @todo : Evaluate this
                        */
                        }else{
                            if(size1==0 && size2==0) continue;
                            std::vector<bool> to_remove_me(tables[j.first].tuple_index.size(), false);
                            for (const auto &m : save_obj.matching_columns) {
                                to_remove_me[m.second] = true;
                            }
                            std::unordered_set<GroundAtom, TupleHash> to_change = save_obj.pos1_hashtable[key_hack];
                            for(auto tup:to_change){
                                for (unsigned pos = 0; pos < to_remove_me.size(); ++pos) {
                                    if (!to_remove_me[pos]) tup.push_back(copy[pos]);
                                }
                                std::vector<int> join_step_key(thesis.old_indices.at(action.get_index()).at(j.second).size());
                                for(size_t pos = 0; pos < thesis.old_indices.at(action.get_index()).at(j.second).size(); pos++){
                                    join_step_key[pos] = tup[pos];
                                }
                                auto pos = save_obj.result_table[join_step_key].find(tup);
                                if(pos!=save_obj.result_table[join_step_key].end()){
                                    save_obj.result_table[join_step_key].erase(tup);
                                    save_obj.result_deleted_single.insert(tup);
                                }
                                if(save_obj.result_table[join_step_key].size()==0) save_obj.result_table.erase(join_step_key);
                            }
                        } 
                    }
                }
            }
            
            //If the AttributeSize of Table2 has changed
            if(save_obj.join_changed_size_second){
                for(auto del:deleted_from_table[j.first]){
                    std::vector<int> join_step_key(thesis.old_indices.at(action.get_index()).at(j.first).size());
                    for(size_t pos = 0; pos < thesis.old_indices.at(action.get_index()).at(j.first).size(); pos++){
                        join_step_key[pos] = del[pos];
                    }
                    if(save_obj.result_table.count(join_step_key)!=0){
                        save_obj.result_deleted_single.insert(save_obj.result_table[join_step_key].begin(),save_obj.result_table[join_step_key].end());
                        save_obj.result_table.erase(join_step_key);
                        deleted_from_table[j.first].insert(join_step_key);
                    }
                }
                if (affected_tables.count(j.first)!=0){
                    for(auto del:old_pos2.result_deleted_single){
                        
                        //If the join result gets bigger, we need to compute the element we want to remove
                        std::vector<int> key(save_obj.matching_columns.size());
                        for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                            key[pos] = del[save_obj.matching_columns[pos].second];
                        }
                        
                        if(save_obj.pos2_hashtable.count(key)){
                            auto pos = save_obj.pos2_hashtable[key].find(del);
                            if(pos!=save_obj.pos2_hashtable[key].end()){
                                save_obj.pos2_hashtable[key].erase(pos);
                                //save_obj.result_deleted_single.insert(del);
                                if(save_obj.pos2_hashtable[key].size()==0) save_obj.pos2_hashtable.erase(key);
                            }


                            if(save_obj.pos1_hashtable.count(key)){
                                std::vector<bool> to_remove_me(tables[j.first].tuple_index.size(), false);
                                for (const auto &m : save_obj.matching_columns) {
                                    to_remove_me[m.second] = true;
                                }
                                std::unordered_set<GroundAtom, TupleHash> to_change = save_obj.pos1_hashtable[key];
                                for(auto tup:to_change){
                                    for (unsigned pos = 0; pos < to_remove_me.size(); ++pos) {
                                        if (!to_remove_me[pos]) tup.push_back(del[pos]);
                                    }
                                    std::vector<int> join_step_key(thesis.old_indices.at(action.get_index()).at(j.second).size());
                                    for(size_t pos = 0; pos < thesis.old_indices.at(action.get_index()).at(j.second).size(); pos++){
                                        join_step_key[pos] = tup[pos];
                                    }
                                    auto pos = save_obj.result_table[join_step_key].find(tup);
                                    if(pos!=save_obj.result_table[join_step_key].end()){
                                        save_obj.result_table[join_step_key].erase(tup);
                                        save_obj.result_deleted_single.insert(tup);
                                    }
                                    if(save_obj.result_table[join_step_key].size()==0) save_obj.result_table.erase(join_step_key);
                                }
                            }
                        }
                    }
                    for(auto del:old_pos2.result_deleted){
                        if(save_obj.result_table.count(del)!=0){
                            save_obj.result_deleted.insert(del);
                            save_obj.result_table.erase(del);
                            deleted_from_table[j.second].insert(del);
                        }
                    }
                }
            }
            
            if(!save_obj.join_changed_size_second){
                for(auto add:save_obj.pos2_added){
                    std::vector<int> key(save_obj.matching_columns.size());
                    for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                        key[pos] = add[save_obj.matching_columns[pos].second];
                    }
                    auto actually_added = save_obj.pos2_hashtable[key].insert(add);
                    //If there is an appropriate join target and the change was not present in the pos2 hashtable yet
                    if(save_obj.pos1_hashtable.count(key) && actually_added.second && save_obj.pos1_hashtable[key].size()!=0){
                        //Compute which positions we want to add
                        std::vector<bool> to_remove_me(tables[j.first].tuple_index.size(), false);
                        for (const auto &m : save_obj.matching_columns) {
                            to_remove_me[m.second] = true;
                        }

                        //Get the join target
                        std::unordered_set<GroundAtom, TupleHash> to_change = save_obj.pos1_hashtable[key];
                        for(auto tup:to_change){
                            //Compute the join
                            for (unsigned pos = 0; pos < to_remove_me.size(); ++pos) {
                                if (!to_remove_me[pos]) tup.push_back(add[pos]);
                            }

                            //If this join has been impacted by filter_static before, also filter this result
                            if(save_obj.check_static) thesis_filter_static(action, tup, save_obj);
                            if(tup.size()!=0){
                                std::vector<int> join_step_key(thesis.old_indices.at(action.get_index()).at(j.second).size());
                                for(size_t pos = 0; pos < thesis.old_indices.at(action.get_index()).at(j.second).size(); pos++){
                                    join_step_key[pos] = tup[pos];
                                }
                                save_obj.result_table[join_step_key].insert(tup);
                                iteration_add_storage.insert(tup);
                            }
                        }
                    }
                }
            }

            //If we have already dealt with the add effect to this table previously, we can add the resulting join in here
            if(save_obj.join_changed_size_second){
                std::unordered_set<GroundAtom, TupleHash> added_result = added_to_table[j.first];
                int access_counter = 0;
                for(auto add:added_result){
                    if(add.size()<=save_obj.result_index.size()){
                        std::vector<int> key(save_obj.matching_columns.size());
                        for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                            key[pos] = add[save_obj.matching_columns[pos].second];
                        }
                        save_obj.pos2_hashtable[key].insert(add);
                        if(save_obj.pos1_hashtable.count(key)!=0){
                            std::vector<bool> to_remove_me(tables[j.first].tuple_index.size(), false);
                            for (const auto &m : save_obj.matching_columns) {
                                to_remove_me[m.second] = true;
                            }
                            std::unordered_set<GroundAtom, TupleHash> to_change = save_obj.pos1_hashtable[key];
                            for(auto tup:to_change){
                                for (unsigned pos = 0; pos < to_remove_me.size(); ++pos) {
                                    if (!to_remove_me[pos]) tup.push_back(add[pos]);
                                }
                                if(save_obj.check_static) thesis_filter_static(action, tup, save_obj);
                                if(tup.size()!=0){
                                    std::vector<int> join_step_key(thesis.old_indices.at(action.get_index()).at(j.second).size());
                                    for(size_t pos = 0; pos < thesis.old_indices.at(action.get_index()).at(j.second).size(); pos++){
                                        join_step_key[pos] = tup[pos];
                                    }
                                    save_obj.result_table[join_step_key].insert(tup);
                                    iteration_add_storage.insert(tup);
                                }
                            }
                        }
                    }
                    access_counter++;
                }
            }
            if(save_obj.join_changed_size_first){
                std::unordered_set<GroundAtom, TupleHash> added_result = added_to_table[j.second];
                int access_counter = 0;
                for(auto add:added_result){
                    bool pass = false;
                    if(!save_obj.pos1_hashtable.empty() && !save_obj.pos1_hashtable.begin()->second.empty()){
                        if(add.size()==save_obj.pos1_hashtable.begin()->second.begin()->size()) pass = true;
                    }else{
                        if(add.size()<=save_obj.result.tuple_index.size()) pass = true;
                    }
                    if(pass){
                        std::vector<int> key(save_obj.matching_columns.size());
                        for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                            key[pos] = add[save_obj.matching_columns[pos].first];
                        }
                        save_obj.pos1_hashtable[key].insert(add);
                        if(save_obj.pos2_hashtable.count(key)!=0){
                            std::vector<bool> to_remove_me(tables[j.first].tuple_index.size(), false);
                            for (const auto &m : save_obj.matching_columns) {
                                to_remove_me[m.second] = true;
                            }
                            std::unordered_set<GroundAtom, TupleHash> to_change = save_obj.pos2_hashtable[key];
                            for(auto tup:to_change){
                                auto copy = add;
                                for (unsigned pos = 0; pos < to_remove_me.size(); ++pos) {
                                    if (!to_remove_me[pos]) copy.push_back(tup[pos]);
                                }
                                if(save_obj.check_static) thesis_filter_static(action, copy, save_obj);
                                if(copy.size()!=0){
                                    std::vector<int> join_step_key(thesis.old_indices.at(action.get_index()).at(j.second).size());
                                    for(size_t pos = 0; pos < thesis.old_indices.at(action.get_index()).at(j.second).size(); pos++){
                                        join_step_key[pos] = copy[pos];
                                    }
                                    save_obj.result_table[join_step_key].insert(copy);
                                    added_to_table[j.second].insert(copy);
                                }
                            }
                        }
                    }else{
                        added_to_table[j.second].erase(add);
                    }
                    access_counter++;
                }
            }else{
                for(auto add:save_obj.pos1_added){
                    //We need to compute the Join 
                    std::vector<bool> to_remove_me(tables[j.first].tuple_index.size(), false);
                    for (const auto &m : save_obj.matching_columns) {
                        to_remove_me[m.second] = true;
                    }
                    std::vector<int> key(save_obj.matching_columns.size());
                    for(size_t pos = 0; pos < save_obj.matching_columns.size(); pos++) {
                        key[pos] = add[save_obj.matching_columns[pos].first];
                    }
                    auto actually_added = save_obj.pos1_hashtable[key].insert(add);
                    if(save_obj.pos2_hashtable.count(key)!=0 && actually_added.second){
                        std::unordered_set<GroundAtom, TupleHash> second_part = save_obj.pos2_hashtable[key];
                        for(auto tup:second_part){
                            GroundAtom new_elem = add;
                            for (unsigned pos = 0; pos < to_remove_me.size(); ++pos) {
                                if (!to_remove_me[pos]) new_elem.push_back(tup[pos]);
                            }
                            if(save_obj.check_static) thesis_filter_static(action, new_elem, save_obj);
                            if(new_elem.size()!=0){
                                save_obj.result_table[add].insert(new_elem);
                                std::unordered_set<GroundAtom, TupleHash>::iterator old = added_to_table[j.second].begin();
                                for(;old!=added_to_table[j.second].end();){
                                    if(old->size()<new_elem.size()){
                                        old = added_to_table[j.second].erase(old);
                                    }else{
                                        old++;
                                    }
                                }
                                added_to_table[j.second].insert(new_elem);
                            }
                        }
                    }
                }
            }
            affected_tables[j.second] = counter;
            
            
            if(iteration_add_storage.size()!=0){
                std::unordered_set<GroundAtom, TupleHash>::iterator old = added_to_table[j.second].begin();
                size_t example_size = iteration_add_storage.begin()->size();
                for(;old!=added_to_table[j.second].end();){
                    if(old->size()<example_size){
                        old = added_to_table[j.second].erase(old);
                    }else{
                        old++;
                    }
                }
                added_to_table[j.second].insert(iteration_add_storage.begin(), iteration_add_storage.end());
            }

            tables[j.second] = save_obj.generate_table();

            project(tables[j.second],project_over,save_obj, thesis.old_indices.at(action.get_index()).at(j.second).size());
            
            if(tables[j.second].tuples.size()==0){
                //if we get an empty result while doing the semi joins, delete the intermediate tables of the previous state
                //they would carry over to the next state, but are not directly connected: n-1 -> n -> n+1
                std::vector<DynamicTables> thesis_empty_semijoins;
                dynamic_semijoin.at(action.get_index()) = std::move(thesis_empty_semijoins);
                return Table::EMPTY_TABLE();
            }


        }else{
            tables[j.second] = thesis_tables.at(action.get_index()).at(counter).result;
            tables[j.second].tuple_index = thesis_tables.at(action.get_index()).at(counter).result_index;
        }
        counter++;
    }

    

    //We have stored everything that was deleted/added to some table
    //If this storage isn´t cleared we will continue to add/delete these atoms in future states as the data structures are carried over betweens states 
    for(long unsigned int i=0;i<thesis_tables.at(action.get_index()).size();i++){
        thesis_tables.at(action.get_index()).at(i).refresh_tables();
    }
    counter = 0;

    Table &working_table = tables[remaining_join[action.get_index()][0]];
    for (size_t i = 1; i < remaining_join[action.get_index()].size(); ++i) {
        DynamicTables join_save;
        hash_join(working_table, tables[remaining_join[action.get_index()][i]]);
        filter_static(action, working_table, join_save);
        if (working_table.tuples.empty()) {
            return working_table;
        }
    }
    
    iteration_time = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::high_resolution_clock::now() - join).count();
    thesis.joinstep_time_me += iteration_time;
    if(iteration_time>thesis.max_join_me) thesis.max_join_me = iteration_time;

    DynamicTables join_save;
    project(working_table, distinguished_variables[action.get_index()],join_save, INT_MAX);

    iteration_time = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::high_resolution_clock::now() - dynamic_timer).count();
    thesis.time_me+= iteration_time;
    if(iteration_time>thesis.max_succ_time_me) thesis.max_succ_time_me = iteration_time;

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
        const Task &task, DynamicState &thesis, std::vector<std::vector<DynamicTables>> &dynamic_join, std::vector<std::vector<DynamicTables>> &dynamic_semijoin, DBState &old_state, bool enable)
{
    if (action.is_ground()) {
        throw std::runtime_error("Shouldn't be calling instantiate() on a ground action");
    }
    if(thesis.is_enabled() && (dynamic_semijoin.at(action.get_index()).size()!=0 && dynamic_join.at(action.get_index()).size()!=0) && enable){
        Table dynamic_table = dynamic_instantiate(action,state,task, thesis, dynamic_join, dynamic_semijoin,old_state);
        return dynamic_table;
    }else{
        if(dynamic_semijoin.size()!=0 && dynamic_semijoin.at(action.get_index()).size()!=0) dynamic_semijoin.at(action.get_index()).clear();
        if(dynamic_join.size()!=0 && dynamic_join.at(action.get_index()).size()!=0) dynamic_join.at(action.get_index()).clear();
        
        thesis.counter_normal++;
        const auto static_timer = std::chrono::high_resolution_clock::now();

        const auto &actiondata = action_data[action.get_index()];
        
        const auto tables_time  = std::chrono::high_resolution_clock::now();
        vector<Table> tables;
        auto res = parse_precond_into_join_program(actiondata, state, tables);
        if (!res){
            return Table::EMPTY_TABLE();
        }
        thesis.time_tables_normal = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::high_resolution_clock::now() - tables_time).count();

        assert(!tables.empty());
        assert(tables.size() == actiondata.relevant_precondition_atoms.size());

        std::unordered_map<int,int> last_changed;
        const auto full_red = std::chrono::high_resolution_clock::now();
        int counter= 0;
        for (const pair<int, int> &sj : full_reducer_order[action.get_index()]) {
            DynamicTables dynamic_semijoin_table;
            size_t before = tables[sj.second].tuples.size();
            size_t s = semi_join(tables[sj.second], tables[sj.first], dynamic_semijoin_table);

            if(before>tables[sj.second].tuples.size()) last_changed.insert_or_assign(sj.second,counter);
            
            if (s == 0) {
                std::vector<DynamicTables> dummy_joins;
                if(thesis.is_enabled()) dynamic_semijoin.at(action.get_index()) = std::move(dummy_joins);
                return Table::EMPTY_TABLE();
            }
            if(thesis.is_enabled()){
                dynamic_semijoin.at(action.get_index()).push_back(dynamic_semijoin_table);
            }
            counter++;
        }

        std::chrono::microseconds::rep iteration_time = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::high_resolution_clock::now() - full_red).count();
        thesis.fullreducer_time_normal+= iteration_time;
        if(iteration_time>thesis.max_fullreducer_normal) thesis.max_fullreducer_normal = iteration_time;
        if(iteration_time<thesis.min_fullreducer_normal) thesis.min_fullreducer_normal = iteration_time;
    
        const JoinTree &jt = join_trees[action.get_index()];

        std::unordered_map<int, std::vector<int>> original_indices;
        for(size_t i=0;i<tables.size();i++){
            original_indices.insert_or_assign(i,tables[i].tuple_index);
        }
        thesis.old_indices[action.get_index()] = original_indices;



        std::vector<bool> consider_changed_size(tables.size(),false);
        counter = 0;
        const auto join = std::chrono::high_resolution_clock::now();
        for (const auto &j : jt.get_order()) {
            DynamicTables dynamic_join_table;
            if(consider_changed_size.at(j.first)){
                dynamic_join_table.join_changed_size_second = true;
            }
            if(consider_changed_size.at(j.second)){
                dynamic_join_table.join_changed_size_first = true;
            }
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
            size_t index_size = working_table.tuple_index.size();

            hash_join(working_table, tables[j.first], dynamic_join_table, original_indices[j.second], original_indices[j.first]);

            if(working_table.tuple_index.size()!=index_size){
                consider_changed_size[j.second] = true;
            }

            // Project must be after removal of inequality constraints, otherwise we might keep only the
            // tuple violating some inequality. Variables in inequalities are also considered
            // distinguished.
           

            filter_static(action, working_table, dynamic_join_table);
            project(working_table, project_over, dynamic_join_table, thesis.old_indices.at(action.get_index()).at(j.second).size());
            if(thesis.is_enabled()) dynamic_join_table.result = working_table;
            if (working_table.tuples.empty()) {
                std::vector<DynamicTables> thesis_empty_joins;
                if(thesis.is_enabled()) dynamic_join.at(action.get_index()) = std::move(thesis_empty_joins);
                return working_table;
            }
            if(thesis.is_enabled()){
 
                dynamic_join.at(action.get_index()).push_back(dynamic_join_table);

            }
            counter++;
           
            //cout << counter << endl;
        }
        // For the case where the action schema is cyclic
        Table &working_table = tables[remaining_join[action.get_index()][0]];
        for (size_t i = 1; i < remaining_join[action.get_index()].size(); ++i) {
            DynamicTables join_save;
            hash_join(working_table, tables[remaining_join[action.get_index()][i]]);
            filter_static(action, working_table, join_save);
            if (working_table.tuples.empty()) {
                return working_table;
            }
        }

        iteration_time = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::high_resolution_clock::now() - join).count();
        thesis.joinstep_time_normal += iteration_time;
        if(iteration_time>thesis.max_join_normal) thesis.max_join_normal = iteration_time;

        DynamicTables dummy;
        project(working_table, distinguished_variables[action.get_index()], dummy, INT_MAX);

        iteration_time = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::high_resolution_clock::now() - static_timer).count();;
        thesis.time_normal+= iteration_time;
        if(iteration_time>thesis.max_succ_time_normal) thesis.max_succ_time_normal = iteration_time;
        
        //cout << working_table.tuples.size() << endl;

        return working_table;
    }

    
}
