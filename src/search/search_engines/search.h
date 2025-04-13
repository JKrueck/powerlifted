#ifndef SEARCH_SEARCH_H
#define SEARCH_SEARCH_H

#include "../search_statistics.h"
#include "../structures.h"
#include "../utils/system.h"

#include <utility>
#include <vector>
#include <map>
#include <chrono>

// Forward declarations
class SuccessorGenerator;
class Heuristic;
class Task;
class DBState;
class SearchNode;
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
                    std::chrono::milliseconds::rep& timer_start, std::chrono::milliseconds::rep& succgen,
                    const DBState &state,
                    const SearchNode &node,
                    const SearchSpace<PackedStateT> &space) const;

protected:

    SearchStatistics statistics;


    static bool is_useful_operator(
        const Task &task,
        const DBState &state,
        const std::vector<std::vector<GroundAtom>> &useful_atoms);

};

#endif //SEARCH_SEARCH_H
