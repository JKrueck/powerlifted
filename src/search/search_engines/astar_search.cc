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

    if (check_goal(task, generator, timer_start, task.initial_state, root_node, space)) return utils::ExitCode::SUCCESS;
    
    int counter = 0;
    while (not queue.empty()) {

        std::vector<Table> thesis_tables;


        StateID sid = queue.remove_min();
        SearchNode &node = space.get_node(sid);
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
        if (check_goal(task, generator, timer_start, state, node, space)) return utils::ExitCode::SUCCESS;
        
        //Create one new Thesis object per state
        ThesisClass thesis_successor(true);

        // Let's expand the state, one schema at a time. If necessary, i.e. if it really helps
        // performance, we could implement some form of std iterator
        for (const auto& action:task.get_action_schemas()) {
            
            //Storage for the Yannakis Table
            Table thes_table = Table::EMPTY_TABLE();
            //Storage for the hash-join matches
            std::unordered_set<int> thesis_matching;
            //Storage of the correspondence between tuple indices in the join tables and predicate index
            std::unordered_map<int,std::vector<int>> thesis_indices;

            
            
            if(action.get_index()==2){
                int wtf = 666;
            }
            auto applicable = generator.get_applicable_actions(action, state, task, thes_table, thesis_matching, thesis_indices);

            thesis_successor.insert_table(thesis_matching);
            thesis_successor.insert_tuple_indices(thesis_indices);
            thesis_successor.insert_match(thesis_matching);
            
            statistics.inc_generated(applicable.size());

            

            for (const LiftedOperatorId& op_id:applicable) {
                DBState s = generator.generate_successor(op_id, action, state, &thesis_successor);

                int dist = g + action.get_cost();
                int new_h = heuristic.compute_heuristic(s, task);
                statistics.inc_evaluations();
                if (new_h == UNSOLVABLE_STATE) {
                    statistics.inc_dead_ends();
                    statistics.inc_pruned_states();
                    continue;
                }

                auto& child_node = space.insert_or_get_previous_node(packer.pack(s), op_id, node.state_id);
                if (child_node.status == SearchNode::Status::NEW) {
                    // Inserted for the first time in the map
                    child_node.open(dist, new_h);
                    statistics.inc_evaluated_states();
                    queue.do_insertion(child_node.state_id, make_pair(new_h+dist, new_h));
                }
                else {
                    if (dist < child_node.g) {
                        child_node.open(dist, new_h); // Reopening
                        statistics.inc_reopened();
                        queue.do_insertion(child_node.state_id, make_pair(new_h+dist, new_h));
                    }
                }
            }
        }
        counter++;
    }

    print_no_solution_found(timer_start);

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
