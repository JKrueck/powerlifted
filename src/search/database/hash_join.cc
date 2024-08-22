#include "hash_join.h"
#include "../hash_structures.h"
#include "table.h"
#include "utils.h"

#include <algorithm>
#include <cassert>
#include <unordered_map>

using namespace std;

std::vector<int> project_tuple(
    const std::vector<int>& tuple,
    const std::vector<int>& pattern)
{
    auto sz = pattern.size();
    vector<int> projected(sz);
    for (size_t i = 0; i < sz; ++i) {
        projected[i] = tuple[pattern[i]];
    }
    return projected;
}
void hash_join(Table &t1, const Table &t2){
    /*
     * This function implements a hash join as follows
     *
     * 1. Start by checking which indexes have the same argument
     * 2. If there is no match, we perform a cartesian product
     * 3. Otherwise, we loop over the first table, create a hash over the
     *    matching keys. Then, loop over the second table searching for hits
     *    in the hash table.
     */
    std::vector<int> matches1, matches2;
    compute_matching_columns(t1, t2, matches1, matches2);
    assert(matches1.size()==matches2.size());
    int remember = t1.tuple_index.size();
    vector<vector<int>> new_tuples;
    if(t2.tuple_index.size()>1){
        int stop=1;
    }
    if (matches1.empty()) {
        /*
         * If no attribute matches, then we apply a cartesian product
         * TODO this code is duplicate from join.cc, make it an auxiliary function
         */
        t1.tuple_index.insert(t1.tuple_index.end(), t2.tuple_index.begin(), t2.tuple_index.end());
        for (const vector<int> &tuple_t1 : t1.tuples) {
            for (const vector<int> &tuple_t2 : t2.tuples) {
                vector<int> aux(tuple_t1);
                aux.insert(aux.end(), tuple_t2.begin(), tuple_t2.end());
                new_tuples.push_back(std::move(aux));
            }
        }
    }
    else {
        std::unordered_map<std::vector<int>, std::unordered_set<std::vector<int>,TupleHash>, TupleHash> temp_pos1;
        //std::unordered_map<std::vector<int>, std::unordered_set<std::vector<int>,TupleHash>, TupleHash> temp_pos2;

        // Remove duplicated index. Duplicate code from join.cc
        vector<bool> to_remove_me(t2.tuple_index.size(), false);
        for (const auto &m : matches2) {
            to_remove_me[m] = true;
        }

        
        
        unordered_map<vector<int>, vector<vector<int>>, TupleHash> hash_join_map;
        // Build phase
        for (const vector<int> &tuple : t1.tuples) {
            hash_join_map[project_tuple(tuple, matches1)].push_back(tuple);
        }

        // Remove duplicated index. Duplicate code from join.cc
        vector<bool> to_remove(t2.tuple_index.size(), false);
        for (const auto &m : matches2) {
            to_remove[m] = true;
        }

        for (size_t j = 0; j < t2.tuple_index.size(); ++j) {
            if (!to_remove[j]) {
                t1.tuple_index.push_back(t2.tuple_index[j]);
            }
        }

        // Probe phase
        for (vector<int> tuple : t2.tuples) {

            auto it = hash_join_map.find(project_tuple(tuple, matches2));

            if (it != hash_join_map.end()) {
                const auto& matching_tuples = it->second;
                for (vector<int> t:matching_tuples) {
                    for (unsigned j = 0; j < to_remove.size(); ++j) {
                        if (!to_remove[j]) t.push_back(tuple[j]);
                    }
                    new_tuples.push_back(std::move(t));
                }
            }
        }
    }
    //Remember if the Join result is larger then the two initial tables
    //if(remember<t1.tuple_index.size()) save.join_changed_sized = true;
    t1.tuples = std::move(new_tuples);
}
void hash_join(Table &t1, const Table &t2, DynamicTables &save, std::vector<int>& semi_indice1, std::vector<int>& semi_indice2) {
    /*
     * This function implements a hash join as follows
     *
     * 1. Start by checking which indexes have the same argument
     * 2. If there is no match, we perform a cartesian product
     * 3. Otherwise, we loop over the first table, create a hash over the
     *    matching keys. Then, loop over the second table searching for hits
     *    in the hash table.
     */
    std::vector<int> matches1, matches2;
    compute_matching_columns(t1, t2, matches1, matches2);
    assert(matches1.size()==matches2.size());
    std::vector<std::pair<int,int>> hack;
    for(int i=0;i<matches1.size();i++){
        std::pair<int,int> match;
        match.first = matches1.at(i);
        match.second = matches2.at(i);
        //The order of the matches will be reversed, but shouldn't matter
        hack.push_back(match);
    }
    save.matching_columns = hack;
    int remember = t1.tuple_index.size();
    vector<vector<int>> new_tuples;
    vector<vector<int>> new_tuples_me;
    if(t2.tuple_index.size()>1){
        int stop=1;
    }
    if (matches1.empty()) {
        /*
         * If no attribute matches, then we apply a cartesian product
         * TODO this code is duplicate from join.cc, make it an auxiliary function
         */
        t1.tuple_index.insert(t1.tuple_index.end(), t2.tuple_index.begin(), t2.tuple_index.end());
        for (const vector<int> &tuple_t1 : t1.tuples) {
            for (const vector<int> &tuple_t2 : t2.tuples) {
                vector<int> aux(tuple_t1);
                aux.insert(aux.end(), tuple_t2.begin(), tuple_t2.end());
                new_tuples_me.push_back(std::move(aux));
            }
        }
        save.result.tuples = new_tuples_me;
        save.result.tuple_index = t1.tuple_index;
        save.result_index = t1.tuple_index;
    }
    else {
        std::unordered_map<std::vector<int>, std::unordered_set<std::vector<int>,TupleHash>, TupleHash> temp_pos1;
        //std::unordered_map<std::vector<int>, std::unordered_set<std::vector<int>,TupleHash>, TupleHash> temp_pos2;

        // Remove duplicated index. Duplicate code from join.cc
        vector<bool> to_remove_me(t2.tuple_index.size(), false);
        for (const auto &m : matches2) {
            to_remove_me[m] = true;
        }

        for (size_t j = 0; j < t2.tuple_index.size(); ++j) {
            if (!to_remove_me[j]) {
                t1.tuple_index.push_back(t2.tuple_index[j]);
            }
        }
        for(int i=0;i<t1.tuples.size();i++){
            std::vector<int> key(hack.size());
            for(size_t j = 0; j < hack.size(); j++) {
                key[j] = t1.tuples.at(i)[hack[j].first];
            }
            /*std::vector<int> old_key(semi_indice1.size());
            for(size_t j = 0; j < semi_indice1.size(); j++){
                old_key[j] = t1.tuples.at(i)[j];
            }*/
            save.pos1_hashtable[key].insert(t1.tuples.at(i));
            temp_pos1[key].insert(t1.tuples.at(i));
        }

        for(int i=0;i<t2.tuples.size();i++){
            std::vector<int> key(hack.size());
            for(size_t j = 0; j < hack.size(); j++) {
                key[j] = t2.tuples.at(i)[hack[j].second];
            }
            /*std::vector<int> old_key(semi_indice2.size());
            for(size_t j = 0; j < semi_indice2.size(); j++){
                old_key[j] = t2.tuples.at(i)[j];
            }*/
            save.pos2_hashtable[key].insert(t2.tuples.at(i));
            if(save.pos1_hashtable.count(key)!=0){
                std::unordered_set<GroundAtom, TupleHash> to_change = save.pos1_hashtable[key];
                for(auto tup:to_change){
                    for (unsigned j = 0; j < to_remove_me.size(); ++j) {
                        if (!to_remove_me[j]) tup.push_back(t2.tuples.at(i)[j]);
                    }
                    new_tuples_me.push_back(tup);
                    std::vector<int> old_key(semi_indice1.size());
                    for(size_t j = 0; j < semi_indice1.size(); j++){
                        old_key[j] = tup[j];
                    }
                    save.result_table[old_key].insert(tup);
                }
            }
        }
    }
    //Remember if the Join result is larger then the two initial tables
    //if(remember<t1.tuple_index.size()) save.join_changed_sized = true;
    save.result.tuples = new_tuples_me;
    save.result_index = t1.tuple_index;
    t1.tuples = std::move(new_tuples_me);
}
