#include "astar_search.h"
#include "search.h"
#include "utils.h"

#include "../open_lists/greedy_open_list.h"
#include "../states/extensional_states.h"
#include "../states/sparse_states.h"
#include "../successor_generators/successor_generator.h"
#include "../utils/timer.h"

#include <algorithm>
#include <iostream>
#include <vector>

using namespace std;

template <class PackedStateT>
utils::ExitCode AStarSearch<PackedStateT>::search(const Task &task,
                                                SuccessorGenerator &generator,
                                                Heuristic &heuristic)
{
    cout << "Starting greedy best first search" << endl;
    clock_t timer_start = clock();
    StatePackerT packer(task);

    GreedyOpenList queue;

    SearchNode& root_node = space.insert_or_get_previous_node(packer.pack(task.initial_state), LiftedOperatorId::no_operator, StateID::no_state);
    utils::Timer t;
    heuristic_layer = heuristic.compute_heuristic(task.initial_state, task);
    t.stop();
    cout << "Time to evaluate initial state: " << t() << endl;
    root_node.open(0, heuristic_layer);
    if (heuristic_layer == numeric_limits<int>::max()) {
        cerr << "Initial state is unsolvable!" << endl;
        exit(1);
    }
    statistics.inc_evaluations();
    cout << "Initial heuristic value " << heuristic_layer << endl;
    statistics.report_f_value_progress(heuristic_layer);
    queue.do_insertion(root_node.state_id, make_pair(heuristic_layer+0, heuristic_layer));

    double thesis_time = 0.0;
    if (check_goal(task, generator, timer_start, task.initial_state, root_node, space, thesis_time)) return utils::ExitCode::SUCCESS;
    
    int counter = 0;

    //Storage for classes per state
    //intended to work similar to queue
    std::unordered_map<int,ThesisClass> thesis_state_memory;
    thesis_state_memory.insert({0,ThesisClass(false,task.get_action_schema_by_index(0))});
    while (not queue.empty()) {

        std::vector<Table> thesis_tables;

        

        StateID sid = queue.remove_min();
        SearchNode &node = space.get_node(sid);

        //Get the thesis object that belongs to the state form the queue -- for now hope the sid is unique
        ThesisClass old_thesis = thesis_state_memory.at(sid.id());

        int h = node.h;
        int g = node.g;
        if (node.status == SearchNode::Status::CLOSED) {
            continue;
        }
        node.close();
        statistics.report_f_value_progress(h); // In GBFS f = h.
        statistics.inc_expanded();

        if (h < heuristic_layer) {
            heuristic_layer = h;
            cout << "New heuristic value expanded: h=" << h
                 << " [expansions: " << statistics.get_expanded()
                 << ", evaluations: " << statistics.get_evaluations()
                 << ", generations: " << statistics.get_generated()
                 << ", time: " << double(clock() - timer_start) / CLOCKS_PER_SEC << "]" << '\n';
        }
        assert(sid.id() >= 0 && (unsigned) sid.id() < space.size());

        DBState state = packer.unpack(space.get_state(sid));
        if (check_goal(task, generator, timer_start, state, node, space, thesis_time)) return utils::ExitCode::SUCCESS;
        

        // Let's expand the state, one schema at a time. If necessary, i.e. if it really helps
        // performance, we could implement some form of std iterator
        for (const auto& action:task.get_action_schemas()) {
            
            //Storage for the Yannakis Table
            //Table thes_table = Table::EMPTY_TABLE();
            //Storage for the hash-join matches
            //std::unordered_set<int> thesis_matching;
            //Storage of the correspondence between tuple indices in the join tables and predicate index
            //std::unordered_map<int,std::vector<int>> thesis_indices;
            std::vector<std::vector<std::pair<Table,bool>>> thesis_join_table_per_state;
            auto applicable = generator.get_applicable_actions(action, state, task, old_thesis, thesis_join_table_per_state, state);

            //thesis_successor.insert_table(thes_table);
            //thesis_successor.insert_tuple_indices(thesis_indices);
            //thesis_successor.insert_match(thesis_matching);
            
            statistics.inc_generated(applicable.size());


            for (const LiftedOperatorId& op_id:applicable) {
                //Create one new Thesis object per state
                ThesisClass thesis_successor(true,action);
                DBState s = generator.generate_successor(op_id, action, state, &thesis_successor);
                
                
                //thesis_successor.set_initial_tables(*(old_thesis.get_initial_tables()));
                //thesis_successor.set_join_tables(*(old_thesis.get_join_tables()));

                int dist = g + action.get_cost();
                int new_h = heuristic.compute_heuristic(s, task);
                statistics.inc_evaluations();
                if (new_h == UNSOLVABLE_STATE) {
                    statistics.inc_dead_ends();
                    statistics.inc_pruned_states();
                    continue;
                }

                auto& child_node = space.insert_or_get_previous_node(packer.pack(s), op_id, node.state_id);
                //cout << child_node.state_id.id()<< endl;
                if (child_node.status == SearchNode::Status::NEW) {
                    // Inserted for the first time in the map
                    child_node.open(dist, new_h);
                    statistics.inc_evaluated_states();
                    queue.do_insertion(child_node.state_id, make_pair(new_h+dist, new_h));
                    thesis_state_memory.insert({child_node.state_id.id(),thesis_successor});
                }
                else {
                    if (dist < child_node.g) {
                        child_node.open(dist, new_h); // Reopening
                        statistics.inc_reopened();
                        queue.do_insertion(child_node.state_id, make_pair(new_h+dist, new_h));
                        thesis_state_memory.insert_or_assign(child_node.state_id.id(),thesis_successor);
                    }
                }
            }
        }
        counter++;
    }

    print_no_solution_found(timer_start, thesis_time);

    return utils::ExitCode::SEARCH_UNSOLVABLE;
}

template <class PackedStateT>
void AStarSearch<PackedStateT>::print_statistics() const {
    statistics.print_detailed_statistics();
    space.print_statistics();
}

// explicit template instantiations
template class AStarSearch<SparsePackedState>;
template class AStarSearch<ExtensionalPackedState>;
