#ifndef SEARCH_YANNAKAKIS_H
#define SEARCH_YANNAKAKIS_H

#include "generic_join_successor.h"

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
                    const DBState &state,const Task &task, ThesisClass &thesis,  std::vector<std::vector<Table>> &thesis_tables) final;
    Table thesis_instantiate(const ActionSchema &action,
                    const DBState &state,const Task &task, Table &thesis_table, std::unordered_set<int> &thesis_matching);

    Table thesis_instantiate2(const ActionSchema &action,const DBState &state,const Task &task, ThesisClass &thesis,  std::vector<std::vector<Table>> &thesis_tables);
    void  filter_delete( std::vector<std::vector<Table>> &thesis_tables ,std::vector<GroundAtom> &diff_delete, int action_id);

 private:
  std::vector<std::vector<std::pair<int, int>>> full_reducer_order;

  std::vector<std::unordered_set<int>> distinguished_variables;

  std::vector<std::vector<int>> remaining_join;

  std::vector<JoinTree> join_trees;

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
