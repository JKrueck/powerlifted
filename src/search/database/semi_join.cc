
#include "semi_join.h"
#include "table.h"
#include "utils.h"

#include <algorithm>

using namespace std;

/**
* Semi-join two tables into one. t1 is the working table and will be modified.
*
* @details We first loop over the parameters of each table and check which indices match.
* Then, we split it into two cases:
* 1. If there are no matching indices, then we simply return
* 2. If at least one parameter matches, we perform a nested loop semi-join.
*
* We return the size of the semi-join in order to be able to identify when
* an empty relation is produced.
*
*/
size_t semi_join(Table &t1, const Table &t2, DynamicTables &save) {

    auto matches = compute_matching_columns(t1, t2);
    save.matching_columns = matches;

    if (matches.empty()) { // If no attribute matches, then we return
        save.result.tuples = t1.tuples;
        save.result.tuple_index = t1.tuple_index;
        save.result_index = t1.tuple_index;
        return t1.tuple_index.size();
    }

    // Otherwise, we perform the join and the projection
    vector<vector<int>> new_tuples;
    for(auto &tuple:t2.tuples){
        std::vector<int> key(matches.size());
        for(size_t i = 0; i < matches.size(); i++) {
            key[i] = tuple[matches[i].second];
        }
        save.pos2_hashtable[key].insert(tuple);
    }

    for(auto &tuple:t1.tuples){
        std::vector<int> key(matches.size());
        for(size_t i = 0; i < matches.size(); i++) {
            key[i] = tuple[matches[i].first];
        }
        save.pos1_hashtable[key].insert(tuple);

        if(save.pos2_hashtable.count(key)!=0){
            new_tuples.push_back(tuple);
            save.result_table[key].insert(tuple);
        }

    }
    
    /*for (const vector<int> &tuple_t1 : t1.tuples) {
        for (const vector<int> &tuple_t2 : t2.tuples) {
            bool match = true;
            for (const pair<int, int>& m : matches) {
                if (tuple_t1[m.first] != tuple_t2[m.second]) {
                    match = false;
                    break;
                }
            }
            if (match) {
                // If a tuple matches at least one other tuple, then it is sufficient for the semi-join
                new_tuples.push_back(tuple_t1);
                break;
            }
        }
    }*/

    save.result.tuples = new_tuples;
    save.result_index = t1.tuple_index;
    t1.tuples = std::move(new_tuples);
    return t1.tuples.size();
}




