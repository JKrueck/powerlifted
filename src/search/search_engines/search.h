#ifndef SEARCH_SEARCH_H
#define SEARCH_SEARCH_H

#include "../search_statistics.h"
#include "../structures.h"
#include "../utils/system.h"

#include "../successor_generators/generic_join_successor.h"

#include <utility>
#include <vector>
#include <map>

// Forward declarations
class SuccessorGenerator;
class Heuristic;
class Task;
class DBState;
class SearchNode;
class DynamicState;
template <typename StateT> class SearchSpace;

class SearchBase {

public:
    SearchBase() = default;
    virtual ~SearchBase() = default;

    virtual utils::ExitCode search(const Task &task,
                       SuccessorGenerator &generator,
                       Heuristic &heuristic) = 0;

    virtual void print_statistics() const = 0;

    template <class PackedStateT>
    bool check_goal(const Task &task,
                    const SuccessorGenerator &generator,
                    clock_t timer_start,
                    const DBState &state,
                    const SearchNode &node,
                    const SearchSpace<PackedStateT> &space,
                    double thesis_time,
                    double thesis_initial,
                    DynamicState the,
                    double cleanup) const;

protected:

    SearchStatistics statistics;


    static bool is_useful_operator(
        const Task &task,
        const DBState &state,
        const std::vector<std::vector<GroundAtom>> &useful_atoms);

};

#endif //SEARCH_SEARCH_H
