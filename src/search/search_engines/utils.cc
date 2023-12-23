
#include "utils.h"

#include "../action.h"
#include "../plan_manager.h"
#include "../task.h"

#include "../successor_generators/successor_generator.h"
#include "../states/sparse_states.h"

#include <algorithm>
#include <fstream>
#include <iostream>
#include <unordered_map>
#include <vector>

using namespace std;

void print_no_solution_found(const clock_t& timer_start,double thesis_time_needed, double thesis_init) {
    cerr << "No solution found!" << endl;
    cout << "Total time: " << double(clock() - timer_start) / CLOCKS_PER_SEC << endl;
    cout << "Time used for successor generation: " << thesis_time_needed / CLOCKS_PER_SEC << endl;
    cout << "Time used for initial state succ gen: " << thesis_init << endl;
}


void print_goal_found(
    const SuccessorGenerator &generator,
    const clock_t& timer_start,double thesis_time_needed, double thesis_init, ThesisClass thes)
{
    cout << "Goal found at: " << double(clock() - timer_start)/CLOCKS_PER_SEC << endl;
    cout << "Total time: " << double(clock() - timer_start)/CLOCKS_PER_SEC << endl;
    cout << "Time used for successor generation: " << thesis_time_needed/CLOCKS_PER_SEC << endl;
    cout << "Time used for initial state succ gen: " << thesis_init << endl;
    cout << "Maximal time used for one dynamic Yannakakis iteration: " << thes.max_succ_time_me << endl;
    cout << "Maximal time used for one normal Yannakakis iteration: " << thes.max_succ_time_normal << endl;
    cout << "---" << endl;

    cout << "Count of calls to me: " << thes.counter_me << endl;
    cout << "Count of calls to normal: " << thes.counter_normal << endl;
    cout << "Time used for my Full Reducer: " << thes.fullreducer_time_me << endl;
    cout << "Time used for normal Full Reducer: " << thes.fullreducer_time_normal << endl;
    if(thes.counter_me!=0) cout << "Average time used for Full Reducer in my stuff: " << (thes.fullreducer_time_me / thes.counter_me)  << endl;
    if(thes.counter_normal!=0) cout << "Average time used for Full Reducer normally: " << (thes.fullreducer_time_normal / thes.counter_normal)  << endl;
    if(thes.counter_me!=0) cout << "Percentage of time used on my full reducer in yannakakis: " << ((thes.fullreducer_time_me / thes.counter_me)/(thes.time_me/thes.counter_me)) << endl;
    if(thes.counter_normal!=0) cout << "Percentage of time normally used on full reducer in yannakakis: " << ((thes.fullreducer_time_normal / thes.counter_normal)/(thes.time_normal/thes.counter_normal)) << endl;
    cout << "Maximal time used on one iteration of my Full Reducer: " << thes.max_fullreducer_me << endl;
    cout << "Maximal time used on one iteration of normal Full Reducer: " << thes.max_fullreducer_normal << endl;
    cout << "Minimal time used on one iteration of my Full Reducer: " << thes.min_fullreducer_me << endl;
    cout << "Minimal time used on one iteration of normal Full Reducer: " << thes.min_fullreducer_normal << endl;
    
    cout << "---" << endl;
    
    cout << "Time used for my Join Step: " << thes.joinstep_time_me << endl;
    cout << "Time used for normal Join Step: " << thes.joinstep_time_normal << endl;
    if(thes.counter_me!=0) cout << "Average time used for join step in my stuff: " << (thes.joinstep_time_me / thes.counter_me)  << endl;
    if(thes.counter_normal!=0) cout << "Average time used for join step normally: " << (thes.joinstep_time_normal / thes.counter_normal)  << endl;
    if(thes.counter_me!=0) cout << "Percentage of time used on my join step in yannakakis: " << ((thes.joinstep_time_me / thes.counter_me)/(thes.time_me/thes.counter_me))<< endl;
    if(thes.counter_me!=0) cout << "Share of the crossproduct on the join step: " << thes.crossproduct_time / thes.joinstep_time_me << endl;
    if(thes.counter_normal!=0) cout << "Percentage of time normally used on join step in yannakakis: " << ((thes.joinstep_time_normal / thes.counter_normal)/(thes.time_normal/thes.counter_normal)) << endl;
    cout << "Maximal time used on one iteration of my Join Step: " << thes.max_join_me << endl;
    cout << "Maximal time used on one iteration of normal Join Step: " << thes.max_join_normal << endl;

    //cout << "Average time used for table generation in my stuff: " << (thes.time_tables_me / thes.counter_me) / CLOCKS_PER_SEC << endl;
    //cout << "Average time used for table generation normally: " << (thes.time_tables_normal / thes.counter_normal) / CLOCKS_PER_SEC << endl;
    //cout << "Percentage of time used on my table generationin yannakakis: " << ((thes.time_tables_me / thes.counter_me)/(thes.time_me/thes.counter_me))<< endl;
    //cout << "Percentage of time normally used on table generation in yannakakis: " << ((thes.time_tables_normal / thes.counter_normal)/(thes.time_me/thes.counter_normal)) << endl;
    

    cout << "---" << endl;

    if(thes.counter_normal!=0) cout << "Average normal time: " << (thes.time_normal/thes.counter_normal)  << endl;
    if(thes.counter_me!=0) cout << "Average me time: " << (thes.time_me/thes.counter_me)  << endl;

    cout << "Share of the successor generation on the overall runtime: " << (thesis_time_needed/CLOCKS_PER_SEC)/(double(clock()-timer_start)/CLOCKS_PER_SEC) << endl;

    cout << "CLOCKS_PER_SEC: " << CLOCKS_PER_SEC << endl; 
    
}

//template<class PackedStateT>
void extract_plan(
    segmented_vector::SegmentedVector<pair<int, LiftedOperatorId>> &cheapest_parent,
    SparsePackedState state,
    const unordered_map<SparsePackedState, int, PackedStateHash> &visited,
    segmented_vector::SegmentedVector<SparsePackedState> &index_to_state,
    const SparseStatePacker &packer,
    const Task &task)
{
    vector<LiftedOperatorId> plan;
    while (cheapest_parent[visited.at(state)].first != -1) {
        plan.push_back(cheapest_parent[visited.at(state)].second);
        state = index_to_state[cheapest_parent[visited.at(state)].first];
    }
    reverse(plan.begin(), plan.end());
    print_plan(plan, task);
}


void print_plan(const std::vector<LiftedOperatorId>& plan, const Task &task) {
    int total_plan_cost = 0;
    int total_plan_length = 0;
    std::ofstream plan_file(PlanManager::get_plan_filename());
    for (const LiftedOperatorId &a:plan) {
        const ActionSchema &action = task.get_action_schema_by_index(a.get_index());
        total_plan_cost += action.get_cost();
        total_plan_length += 1;
        plan_file << total_plan_length << ": (" << action.get_name() << " ";
        for (const int obj : a.get_instantiation()) {
            plan_file << task.objects[obj].get_name() << " ";
        }
        plan_file << ")\n";
    }
    plan_file << "; cost = " << total_plan_cost << '\n';
    std::cout << "Total plan cost: " << total_plan_cost << std::endl;
    std::cout << "Plan length: " << total_plan_length << " step(s)." << std::endl;
}
