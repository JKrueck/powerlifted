#ifndef SEARCH_FULL_REDUCER_SUCCESSOR_GENERATOR_H
#define SEARCH_FULL_REDUCER_SUCCESSOR_GENERATOR_H

#include "generic_join_successor.h"

class FullReducerSuccessorGenerator : public GenericJoinSuccessor {
public:
  /**
   * @see full_reducer_successor_generator.cc
   * @param task
   */
    explicit FullReducerSuccessorGenerator(const Task &task);

    Table instantiate(const ActionSchema &action, const DBState &state,
            const Task &task, ThesisClass &thesis, std::vector<std::vector<ThesisSave>> &thesis_tables, std::vector<std::vector<ThesisSave>> &thesis_semijoin, DBState &old_state) override;

private:
    std::vector<std::vector<std::pair<int, int>>> full_reducer_order;
    std::vector<std::vector<int>> full_join_order;
};


#endif //SEARCH_FULL_REDUCER_SUCCESSOR_GENERATOR_H
