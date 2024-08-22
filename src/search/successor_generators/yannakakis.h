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
                    const DBState &state,const Task &task, DynamicState &thesis, std::vector<std::vector<DynamicTables>> &thesis_tables, std::vector<std::vector<DynamicTables>> &thesis_semijoin, DBState &old_state) final;

    Table dynamic_instantiate(const ActionSchema &action,const DBState &state,const Task &task, DynamicState &thesis, std::vector<std::vector<DynamicTables>> &thesis_tables, std::vector<std::vector<DynamicTables>> &thesis_semijoin, DBState &old_state);
    void deal_with_add_semi(std::pair<int,int> &table_predicates, DynamicTables &save, DynamicTables &join_save, bool revert_join, std::unordered_set<GroundAtom,TupleHash> add_diff, bool first, int tab_id, bool call_on_add_eff, bool ugly_hack);
    void deal_with_del_semi(std::pair<int,int> &table_predicates, DynamicTables &save, DynamicTables &join_save,  bool revert_join, std::unordered_set<GroundAtom,TupleHash> del_diff, bool first, int tab_id, bool ugly_hack);
    void deal_with_add_full(std::pair<int,int> &table_predicates, DynamicTables &save, std::unordered_set<GroundAtom,TupleHash> add_diff, bool first, int index_size);
    void deal_with_del_full(std::pair<int,int> &table_predicates, DynamicTables &save, std::unordered_set<GroundAtom,TupleHash> del_diff, bool first, int index_size);
    void recompute_keys(DynamicTables &save, Table& current_tab, bool first);
    void weird_join(DynamicTables& save, std::vector<int>& index1, std::vector<int>& index2);
    std::unordered_set<GroundAtom,TupleHash> determine_changes(DynamicTables& save, std::unordered_map<std::vector<int>, std::unordered_set<std::vector<int>,TupleHash>, TupleHash>& old_result);
    void determine_changes_crossProduct(DynamicTables& save, Table& old_tab, Table& new_tab);
    void thesis_filter_static(const ActionSchema &action, GroundAtom &check, DynamicTables &save);

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
