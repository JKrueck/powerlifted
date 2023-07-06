
#include "breadth_first_search.h"
#include "../states/extensional_states.h"
#include "../states/sparse_states.h"
#include "../successor_generators/successor_generator.h"
#include "../task.h"
#include "utils.h"

#include <iostream>
#include <queue>
#include <vector>

using namespace std;

template <class PackedStateT>
utils::ExitCode BreadthFirstSearch<PackedStateT>::search(const Task &task,
                                             SuccessorGenerator &generator,
                                             Heuristic &heuristic)
{
    cout << "Starting breadth first search" << endl;
    clock_t timer_start = clock();

    StatePackerT packer(task);
    std::queue<StateID> queue;

    SearchNode& root_node = space.insert_or_get_previous_node(packer.pack(task.initial_state), LiftedOperatorId::no_operator, StateID::no_state);
    root_node.open(0);
    cout << "Initial heuristic value 0" << endl;
    statistics.report_f_value_progress(root_node.f);
    queue.emplace(root_node.state_id);

    if (check_goal(task, generator, timer_start, task.initial_state, root_node, space)) return utils::ExitCode::SUCCESS;

    //Save the intermediate join tables at a global level and per action
    std::vector<std::vector<Table>> thesis_join_table_memory;
    thesis_join_table_memory.resize(task.get_action_schemas().size());
    //As we always want to use the join tables from the prior state, we need to save all of them on a per state basis
    //To-Do: Think about when we don´t need them anymore and can delete them from memory
    std::unordered_map<int,std::vector<std::vector<Table>>> thesis_join_table_per_state; //great names...
    thesis_join_table_per_state.insert({0,thesis_join_table_memory});

    //Storage for classes per state
    //intended to work similar to queue
    std::unordered_map<int,ThesisClass> thesis_state_memory;
    thesis_state_memory.insert({0,ThesisClass(false,task.get_action_schema_by_index(0))});
    while (not queue.empty()) {
        StateID sid = queue.front();
        queue.pop();
        SearchNode &node = space.get_node(sid);

        //Get the thesis object that belongs to the state form the queue -- for now hope the sid is unique
        ThesisClass old_thesis = thesis_state_memory.at(sid.id());
        std::vector<std::vector<Table>> thesis_current_tables = thesis_join_table_per_state.at(sid.id());
        //remove the thesis object from memory
        thesis_state_memory.erase(sid.id());

        if (node.status == SearchNode::Status::CLOSED) {
            continue;
        }
        node.close();
        statistics.report_f_value_progress(node.f);
        statistics.inc_expanded();

        assert(sid.id() >= 0 && (unsigned) sid.id() < space.size());

        DBState state = packer.unpack(space.get_state(sid));

         //Storage for classes per state
   

        // Let's expand the state, one schema at a time. If necessary, i.e. if it really helps
        // performance, we could implement some form of std iterator
        for (const auto& action : task.get_action_schemas()) {

            //Storage for the Yannakis Table
            //Table thes_table = Table::EMPTY_TABLE();
            //Storage for the hash-join matches
            //std::unordered_set<int> thesis_matching;
            //Storage of the correspondence between tuple indices in the join tables and predicate index
            //std::unordered_map<int,std::vector<int>> thesis_indices;
            //Create one new Thesis object per state
            //ThesisClass thesis_successor(true,action);

            auto applicable = generator.get_applicable_actions(action, state,task, old_thesis, thesis_current_tables);
            statistics.inc_generated(applicable.size());

            

            for (const LiftedOperatorId &op_id:applicable) {

                //Create one new Thesis object per state
                ThesisClass thesis_successor(false,action,state);
                if(this->thesis_enabled){
                    thesis_successor.set_status(true);
                }

                DBState s = generator.generate_successor(op_id, action, state, &thesis_successor);

                thesis_successor.set_join_tables(*(old_thesis.get_join_tables()));

                auto& child_node = space.insert_or_get_previous_node(packer.pack(s), op_id, node.state_id);
                if (child_node.status == SearchNode::Status::NEW) {
                    child_node.open(node.f+1);

                    if (check_goal(task, generator, timer_start, s, child_node, space)) return utils::ExitCode::SUCCESS;

                    queue.emplace(child_node.state_id);

                    thesis_state_memory.insert({child_node.state_id.id(),thesis_successor});
                }
            }
        }
    }

    print_no_solution_found(timer_start);

    return utils::ExitCode::SEARCH_UNSOLVABLE;
}

template <class PackedStateT>
void BreadthFirstSearch<PackedStateT>::print_statistics() const {
    statistics.print_detailed_statistics();
    space.print_statistics();
}

// explicit template instantiations
template class BreadthFirstSearch<SparsePackedState>;
template class BreadthFirstSearch<ExtensionalPackedState>;
