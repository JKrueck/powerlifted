#ifndef SEARCH_HEURISTIC_H
#define SEARCH_HEURISTIC_H

#include "../states/state.h"
#include "../task.h"

class Heuristic {
public:
    virtual ~Heuristic() = default;
    /**
     * @brief Virtual implementation of a heuristic function
     * @param s: State being evaluated
     * @param task: Planning task
     * @return Heuristic value
     */
    virtual int compute_heuristic(const State &s, const Task &task) = 0;
};

#endif //SEARCH_HEURISTIC_H
