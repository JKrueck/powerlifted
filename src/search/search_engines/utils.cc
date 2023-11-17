
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
    cout << "Time used for successor generation: " << thesis_time_needed / CLOCKS_PER_SEC << endl;
    cout << "Time used for initial state succ gen: " << thesis_init << endl;

    cout << "---" << endl;

    cout << "Count of calls to me: " << thes.counter_me << endl;
    cout << "Count of calls to normal: " << thes.counter_normal << endl;
    cout << "Time used for my Full Reducer: " << thes.fullreducer_time_me/CLOCKS_PER_SEC << endl;
    cout << "Time used for normal Full Reducer: " << thes.fullreducer_time_normal/CLOCKS_PER_SEC << endl;
    if(thes.counter_me!=0) cout << "Average time used for Full Reducer in my stuff: " << (thes.fullreducer_time_me / thes.counter_me) / CLOCKS_PER_SEC << endl;
    if(thes.counter_normal!=0) cout << "Average time used for Full Reducer normally: " << (thes.fullreducer_time_normal / thes.counter_normal) / CLOCKS_PER_SEC << endl;
    if(thes.counter_me!=0) cout << "Percentage of time used on my full reducer in yannakakis: " << ((thes.fullreducer_time_me / thes.counter_me)/(thes.time_me/thes.counter_me)) << endl;
    if(thes.counter_normal!=0) cout << "Percentage of time normally used on full reducer in yannakakis: " << ((thes.fullreducer_time_normal / thes.counter_normal)/(thes.time_normal/thes.counter_normal)) << endl;
    
    cout << "---" << endl;
    
    cout << "Time used for my Join Step: " << thes.joinstep_time_me/CLOCKS_PER_SEC << endl;
    cout << "Time used for normal Join Step: " << thes.joinstep_time_normal/CLOCKS_PER_SEC << endl;
    if(thes.counter_me!=0) cout << "Average time used for join step in my stuff: " << (thes.joinstep_time_me / thes.counter_me) / CLOCKS_PER_SEC << endl;
    if(thes.counter_normal!=0) cout << "Average time used for join step normally: " << (thes.joinstep_time_normal / thes.counter_normal) / CLOCKS_PER_SEC << endl;
    if(thes.counter_me!=0) cout << "Percentage of time used on my join step in yannakakis: " << ((thes.joinstep_time_me / thes.counter_me)/(thes.time_me/thes.counter_me))<< endl;
    if(thes.counter_normal!=0) cout << "Percentage of time normally used on join step in yannakakis: " << ((thes.joinstep_time_normal / thes.counter_normal)/(thes.time_normal/thes.counter_normal)) << endl;
    

    //cout << "Average time used for table generation in my stuff: " << (thes.time_tables_me / thes.counter_me) / CLOCKS_PER_SEC << endl;
    //cout << "Average time used for table generation normally: " << (thes.time_tables_normal / thes.counter_normal) / CLOCKS_PER_SEC << endl;
    //cout << "Percentage of time used on my table generationin yannakakis: " << ((thes.time_tables_me / thes.counter_me)/(thes.time_me/thes.counter_me))<< endl;
    //cout << "Percentage of time normally used on table generation in yannakakis: " << ((thes.time_tables_normal / thes.counter_normal)/(thes.time_me/thes.counter_normal)) << endl;
    
    cout << "---" << endl;

    cout << "Percentage of my join time used on first join case: " << (thes.joinstep_case1/thes.joinstep_time_me) << endl;
    cout << "Percentage of my join time used on second join case: " << (thes.joinstep_case2/thes.joinstep_time_me) << endl; 
    cout << "Percentage of my join time used on third join case: " << (thes.joinstep_case3/thes.joinstep_time_me) << endl; 
    cout << "Percentage of my join time used on fourth join case: " << (thes.joinstep_case4/thes.joinstep_time_me) << endl; 
    cout << "Percentage of my join time used on fifth join case: " << (thes.joinstep_case5/thes.joinstep_time_me) << endl; 

    cout << "---" << endl;

    cout << "Average Percentage of my join time used on first join case: " << (thes.joinstep_case1/thes.counter_joinstep_case1)/thes.joinstep_time_me   << endl;
    cout << "Average Percentage of my join time used on second join case: " << (thes.joinstep_case2/thes.counter_joinstep_case2)/thes.joinstep_time_me  << endl; 
    cout << "Average Percentage of my join time used on third join case: " << (thes.joinstep_case3/thes.counter_joinstep_case3 )/thes.joinstep_time_me  << endl; 
    cout << "Average Percentage of my join time used on fourth join case: " << (thes.joinstep_case4/thes.counter_joinstep_case4)/thes.joinstep_time_me  << endl; 
    cout << "Average Percentage of my join time used on fifth join case: " << (thes.joinstep_case5/thes.counter_joinstep_case5)/thes.joinstep_time_me   << endl; 

    cout << "---" << endl;

    cout << "Amount of calls of first join case: " << thes.counter_joinstep_case1    << endl;
    cout << "Amount of calls of second join case: " << thes.counter_joinstep_case2    << endl; 
    cout << "Amount of calls of third join case: " << thes.counter_joinstep_case3    << endl; 
    cout << "Amount of calls of fourth join case: " << thes.counter_joinstep_case4   << endl; 
    cout << "Amount of calls of fifth join case: " << thes.counter_joinstep_case5    << endl; 

    cout << "---" << endl;

    cout << "Percentage of my Full Reducer time used on determine_changes function: " << (thes.time_det_changes / thes.fullreducer_time_me) << endl;
    //cout << "Average time used for determine_changes function: " << (thes.time_det_changes / thes.counter_det_changes)/CLOCKS_PER_SEC << endl;
    cout << "Amount of calls to weird del case: " << thes.counter_weirdCase << endl;
    if(thes.counter_det_changeCross!=0)cout << "Average time used for determine_changes_crossProduct function: " <<  (thes.time_det_changesCross / thes.counter_det_changeCross)/CLOCKS_PER_SEC << endl;
    else cout << "Average time used for determine_changes_crossProduct function: 0.0" << endl;
    cout << "Amount of calls to determine_changes_crossProduct function: " << thes.counter_det_changeCross << endl;

    cout << "---" << endl;

    cout << "Average time used for weird_join function: " << (thes.time_weirdJoin/thes.counter_weirdJoin)/CLOCKS_PER_SEC << endl;
    cout << "Average time used for recompute_keys function: " << (thes.time_recomputeKeys/thes.counter_recomputeKeys)/CLOCKS_PER_SEC << endl;
    cout << "Percentage of my Join Step time used on weird_join: " << thes.time_weirdJoin/thes.joinstep_time_me << endl;
    cout << "Percentage of my Join Step time used on recompute_keys: " << thes.time_recomputeKeys/thes.joinstep_time_me << endl;

    cout << "---" << endl;

    

    if(thes.counter_normal!=0) cout << "Average normal time: " << (thes.time_normal/thes.counter_normal) / CLOCKS_PER_SEC << endl;
    if(thes.counter_me!=0) cout << "Average me time: " << (thes.time_me/thes.counter_me) / CLOCKS_PER_SEC << endl;
    
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
