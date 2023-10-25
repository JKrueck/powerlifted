#ifndef SEARCH_YANNAKAKIS_H
#define SEARCH_YANNAKAKIS_H

#include "generic_join_successor.h"
#include "../hash_structures.h"
#include <boost/functional/hash/hash.hpp>

class JoinTree;

class YannakakisSuccessorGenerator : public GenericJoinSuccessor {
    using tuple_t = std::vector<int>;
    using GroundAtom = std::vector<int>;
 public:
  /**
 * @see yannakakis.cc
 * @param task
 */
  explicit YannakakisSuccessorGenerator(const Task &task);
    Table instantiate(const ActionSchema &action,
                    const DBState &state,const Task &task, ThesisClass &thesis, std::vector<std::vector<ThesisSave>> &thesis_tables, std::vector<std::vector<ThesisSave>> &thesis_semijoin, DBState &old_state) final;
    //Table thesis_instantiate(const ActionSchema &action,
                    //const DBState &state,const Task &task, Table &thesis_table, std::unordered_set<int> &thesis_matching);

    Table thesis_instantiate2(const ActionSchema &action,const DBState &state,const Task &task, ThesisClass &thesis, std::vector<std::vector<ThesisSave>> &thesis_tables, std::vector<std::vector<ThesisSave>> &thesis_semijoin, DBState &old_state);
    void deal_with_add_semi(std::pair<int,int> &table_predicates, ThesisSave &save, std::unordered_set<GroundAtom,TupleHash> add_diff, bool first);
    void deal_with_del_semi(std::pair<int,int> &table_predicates, ThesisSave &save, std::unordered_set<GroundAtom,TupleHash> del_diff, bool first);
    void deal_with_add_full(std::pair<int,int> &table_predicates, ThesisSave &save, std::unordered_set<GroundAtom,TupleHash> add_diff, bool first, int index_size);
    void deal_with_del_full(std::pair<int,int> &table_predicates, ThesisSave &save, std::unordered_set<GroundAtom,TupleHash> del_diff, bool first, int index_size);

    void thesis_compute_del_impacts(const Task &task);
    bool thesis_called = false;
 private:
    std::vector<std::vector<std::pair<int, int>>> full_reducer_order;

    std::vector<std::unordered_set<int>> distinguished_variables;

    std::vector<std::vector<int>> remaining_join;

    std::vector<JoinTree> join_trees;

    std::vector<std::vector<std::pair<int,int>>> thesis_del_impacts;

    void get_distinguished_variables(const ActionSchema &action);
};

class JoinTree {
    std::vector<std::pair<int, int>> join_tree_order;

public:
    JoinTree() = default;

    void add_node(int i, int j) {
        join_tree_order.emplace_back(i, j);
    }

    const std::vector<std::pair<int, int>> &get_order() const {
        return join_tree_order;
    }

};


#endif //SEARCH_YANNAKAKIS_H
