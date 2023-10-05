
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
size_t semi_join(Table &t1, const Table &t2) {

    auto matches = compute_matching_columns(t1, t2);

    if (matches.empty()) { // If no attribute matches, then we return
        return t1.tuple_index.size();
    }

    // Otherwise, we perform the join and the projection
    vector<std::set<int>> new_tuples;
    for (const std::set<int> &tuple_t1 : t1.tuples) {
        for (const std::set<int> &tuple_t2 : t2.tuples) {
            bool match = true;
            for (const pair<int, int>& m : matches) {
                // Increment the iterators until they reach the right position in their sets
                // THIS PROBABLY DOES NOT WORK LIKE THIS AAAAA
                // MAYBE IT DOES?????
                std::set<int>::iterator test1 = tuple_t1.begin();
                std::set<int>::iterator test2 = tuple_t2.begin();
                for(int i=0;i<m.first;i++){
                    test1++;
                }
                for(int i=0;i<m.second;i++){
                    test2++;
                }
                if (*test1 != *test2) {
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
    }
    t1.tuples = std::move(new_tuples);
    return t1.tuples.size();
}




