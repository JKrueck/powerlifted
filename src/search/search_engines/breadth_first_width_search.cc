#include "breadth_first_width_search.h"
#include "search.h"
#include "utils.h"

#include "../open_lists/tiebreaking_open_list.h"

#include "../heuristics/ff_heuristic.h"

#include "../states/extensional_states.h"
#include "../states/sparse_states.h"

#include "../parallel_hashmap/phmap.h"
#include "../successor_generators/successor_generator.h"

#include <iostream>
#include <vector>


using namespace std;

template<class PackedStateT>
BreadthFirstWidthSearch<PackedStateT>::BreadthFirstWidthSearch(int width,
                                                               const Options &opt,
                                                               int method) : width(width),
                                                                             method(method),
                                                                             only_effects_opt(opt.get_only_effects_opt()),
                                                                             early_stop(opt.get_novelty_early_stop()) {
    if ((method == StandardNovelty::IW) || (method == StandardNovelty::IW_G)) {
        prune_states = true;
    }
    else {
        prune_states = false;
    }
    if (method == StandardNovelty::R_X) {
        std::cout << "Using version with R-X" << std::endl;
    }

    this->thesis_enabled = thesis_enabled = opt.get_thesis_state();
}


template <class PackedStateT>
utils::ExitCode BreadthFirstWidthSearch<PackedStateT>::search(const Task &task,
                                                            SuccessorGenerator &generator,
                                                            Heuristic &heuristic)
{
    
    double thesis_time = 0.0;
    double thesis_initial_succ = 0.0;
    double cleanup = 0.0;
    cout << "Starting BFWS" << endl;
    clock_t timer_start = clock();
    StatePackerT packer(task);

    Goalcount gc;

    size_t number_goal_conditions = task.get_goal().goal.size() + task.get_goal().positive_nullary_goals.size() + task.get_goal().negative_nullary_goals.size();
    size_t number_relevant_atoms;

    if (method == StandardNovelty::R_X) {
        atom_counter = initialize_counter_with_useful_atoms(task);
        number_relevant_atoms = atom_counter.get_total_number_of_atoms();
    }
    else {
        atom_counter = initialize_counter_with_gc(task);
        number_relevant_atoms = 0;
    }

    // We use a GreedyOpenList (ordered by the novelty value) for now. This is done to make the
    // search algorithm complete.
    TieBreakingOpenList queue;

    phmap::flat_hash_map<int, NodeNovelty> map_state_to_evaluators;

    SearchNode& root_node = space.insert_or_get_previous_node(packer.pack(task.initial_state),
        LiftedOperatorId::no_operator, StateID::no_state);
    utils::Timer t;

    StandardNovelty novelty_evaluator(task, number_goal_conditions, number_relevant_atoms, width);

    int gc_h0 = gc.compute_heuristic(task.initial_state, task);

    int unachieved_atoms_s0 = 0;
    if (method == StandardNovelty::R_X)
        unachieved_atoms_s0 = atom_counter.count_unachieved_atoms(task.initial_state, task);

    int novelty_value = novelty_evaluator.compute_novelty(task, task.initial_state, gc_h0, unachieved_atoms_s0);

    root_node.open(0, novelty_value);

    statistics.inc_evaluations();
    cout << "Initial heuristic value " << heuristic_layer << endl;

    GenericDynamicSearchSetup dynamic_setup(task, this->thesis_enabled);

    statistics.report_f_value_progress(heuristic_layer);
    queue.do_insertion(root_node.state_id, {novelty_value,
                                            gc_h0,
                                            0});

    map_state_to_evaluators.insert({root_node.state_id.id(), NodeNovelty(gc_h0, unachieved_atoms_s0)});
    
    if (check_goal(task, generator, timer_start, task.initial_state, root_node, space, thesis_time, thesis_initial_succ, dynamic_setup.dynamic_state_memory.at(0),cleanup)) return utils::ExitCode::SUCCESS;

    while (not queue.empty()) {
        StateID sid = queue.remove_min();
        SearchNode &node = space.get_node(sid);
        int g = node.g;
        if (node.status == SearchNode::Status::CLOSED) {
            continue;
        }
        node.close();
        statistics.report_f_value_progress(g); // In GBFS f = h.
        statistics.inc_expanded();

        assert(sid.id() >= 0 && (unsigned) sid.id() < space.size());

        DBState state = packer.unpack(space.get_state(sid));
        //if (check_goal(task, generator, timer_start, state, node, space)) return utils::ExitCode::SUCCESS;

        int unsatisfied_goal_parent = map_state_to_evaluators.at(sid.id()).unsatisfied_goals;
        int unsatisfied_relevant_atoms_parent = map_state_to_evaluators.at(sid.id()).unsatisfied_relevant_atoms;

        
        
        //Get the thesis object that belongs to the state from the queue
        DynamicState old_dynamic_state = dynamic_setup.dynamic_state_memory.at(sid.id());
        //remove the thesis object from memory
        dynamic_setup.dynamic_state_memory.erase(sid.id());

        //get all hash tables that were computed in the previous state
        dynamic_setup.join_table_per_state = dynamic_setup.join_table_memory.at(old_dynamic_state.get_parent_state_id());
        std::vector<std::vector<DynamicTables>> semijoin_table_at_state = dynamic_setup.semijoin_table_memory.at(old_dynamic_state.get_parent_state_id());
        semijoin_table_at_state.resize(task.get_action_schemas().size());
        if(sid.id()!=0){
            dynamic_setup.semijoin_table_memory.insert_or_assign(sid.id(),semijoin_table_at_state);
            dynamic_setup.join_table_memory.insert_or_assign(sid.id(), dynamic_setup.join_table_per_state);
        }

        if(this->thesis_enabled && sid.id()!=0){
            std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> predicate_to_add_diff;
            std::unordered_map<int,bool> diff_delete;

            dynamic_setup.state_delta(task, old_dynamic_state, predicate_to_add_diff, diff_delete);
        }


        for (const auto& action:task.get_action_schemas()) {
            
            time_t thesis_timer = clock();
            time_t thesis_initial_timer = clock();
            old_dynamic_state.old_indices = dynamic_setup.old_indices_gblhack;

            DBState old_state;


            auto applicable = generator.get_applicable_actions(action, state,task, old_dynamic_state,
                                dynamic_setup.join_table_per_state,semijoin_table_at_state,old_state);
            
            
            statistics.inc_generated(applicable.size());

            //Sort the instantiations by their hash
            //Maybe think about this. Now that we know that the algo works correctly, we can maybe remove this
            std::sort(applicable.begin(),applicable.end());
            
            thesis_time += clock() - thesis_timer;
            if(sid.id()==0){
                thesis_initial_succ += clock() - thesis_initial_timer;
            }

            //Save the new dynamic tables that were generated through the applocable actions calculation
            dynamic_setup.semijoin_table_memory.at(sid.id()).at(action.get_index()) = std::move(semijoin_table_at_state.at(action.get_index()));
            dynamic_setup.join_table_memory.at(sid.id()).at(action.get_index()) = std::move(dynamic_setup.join_table_per_state.at(action.get_index()));
            dynamic_setup.old_indices_gblhack = old_dynamic_state.old_indices;


            for (const LiftedOperatorId& op_id:applicable) {
                
                DynamicState dynamic_successor(false,action);
                
                dynamic_successor.set_parent_state_id(sid.id());
                dynamic_successor.action_id = action.get_index();
                dynamic_successor.set_instantiation(op_id.get_instantiation());

                dynamic_setup.time_tracking(dynamic_successor, old_dynamic_state);
                dynamic_successor.old_indices = old_dynamic_state.old_indices;
                
                DBState s = generator.generate_successor(op_id, action, state, &dynamic_successor);
                auto& child_node = space.insert_or_get_previous_node(packer.pack(s), op_id, node.state_id);
                if (child_node.status != SearchNode::Status::NEW)
                    continue;

                int dist = g + action.get_cost();
                int unsatisfied_goals = gc.compute_heuristic(s, task);
                int unsatisfied_relevant_atoms = 0;

                if (method == StandardNovelty::IW) {
                    unsatisfied_relevant_atoms = 0;
                    // Important is to make it constant different than 0, otherwise the novelty will
                    // be 0 because of the goal detection in the evaluator.
                    unsatisfied_goals = 1;
                }
                if (method == StandardNovelty::R_X)
                    unsatisfied_relevant_atoms = atom_counter.count_unachieved_atoms(s, task);

                if (only_effects_opt and (unsatisfied_goals == unsatisfied_goal_parent) and (unsatisfied_relevant_atoms == unsatisfied_relevant_atoms_parent)) {
                    novelty_value = novelty_evaluator.compute_novelty_from_operator(task,
                                                                                    s,
                                                                                    unsatisfied_goals,
                                                                                    unsatisfied_relevant_atoms,
                                                                                    generator.get_added_atoms());
                }
                else {
                    novelty_value = novelty_evaluator.compute_novelty(task,
                                                                      s,
                                                                      unsatisfied_goals,
                                                                      unsatisfied_relevant_atoms);

                }

                statistics.inc_evaluations();
                statistics.inc_evaluated_states();

                if ((prune_states) and (novelty_value == StandardNovelty::NOVELTY_GREATER_THAN_TWO))
                    continue;

                child_node.open(dist, novelty_value);
                if (check_goal(task, generator, timer_start, task.initial_state, root_node, space, thesis_time, thesis_initial_succ, dynamic_successor, cleanup)) return utils::ExitCode::SUCCESS;
                queue.do_insertion(child_node.state_id, {novelty_value, unsatisfied_goals, dist});
                map_state_to_evaluators.insert({child_node.state_id.id(), NodeNovelty(unsatisfied_goals, unsatisfied_relevant_atoms)});
            
                dynamic_setup.dynamic_state_memory.insert({child_node.state_id.id(),dynamic_successor});
                    //create a new empty join_table memory for the new state
                    std::vector<std::vector<Table>> thesis_join_at_state;
                    std::vector<std::vector<Table>> thesis_semijoin_at_state;
                    //remember that sid is the parent state of the current child node
                    dynamic_setup.dynamic_previous_state.insert_or_assign(child_node.state_id,sid);

            }
        }
    }

    print_no_solution_found(timer_start, thesis_time, thesis_initial_succ);

    if (prune_states)
        return utils::ExitCode::SEARCH_UNSOLVED_INCOMPLETE;
    return utils::ExitCode::SEARCH_UNSOLVABLE;
}

template <class PackedStateT>
void BreadthFirstWidthSearch<PackedStateT>::print_statistics() const {
    statistics.print_detailed_statistics();
    space.print_statistics();
}

template<class PackedStateT>
AtomCounter BreadthFirstWidthSearch<PackedStateT>::initialize_counter_with_gc(const Task &task) {
    std::vector<std::vector<GroundAtom>> atoms(task.initial_state.get_relations().size(), std::vector<GroundAtom>());
    std::unordered_set<int> positive = task.get_goal().positive_nullary_goals;
    std::unordered_set<int> negative = task.get_goal().negative_nullary_goals;

     for (const AtomicGoal &atomic_goal : task.get_goal().goal) {
         size_t pred_idx = atomic_goal.get_predicate_index();
         if (task.predicates[pred_idx].isStaticPredicate())
             continue;
         atoms[pred_idx].push_back(atomic_goal.get_arguments());
     }

    return AtomCounter(atoms, positive, negative);
}


template<class PackedStateT>
AtomCounter BreadthFirstWidthSearch<PackedStateT>::initialize_counter_with_useful_atoms(const Task &task) {
    std::vector<std::vector<GroundAtom>> atoms(task.initial_state.get_relations().size(), std::vector<GroundAtom>());
    std::unordered_set<int> positive = task.get_goal().positive_nullary_goals;
    std::unordered_set<int> negative = task.get_goal().negative_nullary_goals;

    FFHeuristic delete_free_h(task);

    int h = delete_free_h.compute_heuristic(task.initial_state, task);
    std::cout << "Initial h-add value of the task: " << h << std::endl;

    std::vector<bool> useful_nullary = delete_free_h.get_useful_nullary_atoms();
    for (size_t i = 0; i < useful_nullary.size(); ++i) {
        if (useful_nullary[i]) {
            positive.insert(i);
        }
    }

    const std::vector<std::vector<GroundAtom>> &useful_atoms = delete_free_h.get_useful_atoms();
    int pred_idx = 0;
    for (const auto &entry : useful_atoms) {
        if (task.predicates[pred_idx].isStaticPredicate()) {
            ++pred_idx;
            continue;
        }
        for (const GroundAtom &atom : entry) {
            atoms[pred_idx].push_back(atom);
        }
        ++pred_idx;
    }

    return AtomCounter(atoms, positive, negative);
}

// explicit template instantiations
template class BreadthFirstWidthSearch<SparsePackedState>;
template class BreadthFirstWidthSearch<ExtensionalPackedState>;//