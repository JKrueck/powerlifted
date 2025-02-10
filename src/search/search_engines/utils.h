
#pragma once

#include "../utils/segmented_vector.h"
#include "../successor_generators/successor_generator.h"

#include <ctime>
#include <utility>
#include <unordered_map>
#include <vector>
#include <chrono>

class LiftedOperatorId;
class PackedStateHash;
class SuccessorGenerator;
class SparsePackedState;
class SparseStatePacker;
class Task;
class ThesisClass;


void print_no_solution_found(std::chrono::milliseconds::rep& timer_start, std::chrono::milliseconds::rep& thesis_time_needed, std::chrono::milliseconds::rep& thesis_init);

void print_goal_found(
    const SuccessorGenerator& generator,
    std::chrono::milliseconds::rep& timer_start,
    std::chrono::milliseconds::rep& thesis_time_needed,
    std::chrono::milliseconds::rep& thesis_init,
    DynamicState the,
    std::chrono::milliseconds::rep& cleanup);


void extract_plan(
    segmented_vector::SegmentedVector<std::pair<int, LiftedOperatorId>> &cheapest_parent,
    SparsePackedState state,
    const std::unordered_map<SparsePackedState, int, PackedStateHash> &visited,
    segmented_vector::SegmentedVector<SparsePackedState> &index_to_state,
    const SparseStatePacker &packer,
    const Task &task);

void print_plan(const std::vector<LiftedOperatorId>& plan, const Task &task);
