#include "alternated_bfws.h"

#include "search.h"
#include "utils.h"

#include "../heuristics/heuristic_factory.h"

#include "../successor_generators/successor_generator.h"

#include "../states/extensional_states.h"
#include "../states/sparse_states.h"

#include "../parallel_hashmap/phmap.h"

#include <algorithm>
#include <iostream>
#include <vector>


using namespace std;

class AlternatedOpenListManager {
    TieBreakingOpenList novelty_regular_open_list;
    TieBreakingOpenList novelty_preferred_open_list;
    GreedyOpenList hadd_preferred_open_list;
    GreedyOpenList hadd_regular_open_list;

    int counter;
    int priority;

    const int NOVELTY_TURN = 0;
    const int H_ADD_TURN = 1;

public:
    AlternatedOpenListManager() {
        counter = H_ADD_TURN;
        priority = 1000;
    }

    void do_insertion(const StateID &entry, int h, int g, int unsatisfied_goals, int novelty, bool preferred) {
        if (preferred) {
            novelty_preferred_open_list.do_insertion(entry, {novelty, unsatisfied_goals, g});
            hadd_preferred_open_list.do_insertion(entry, {h, g});
        }
        novelty_regular_open_list.do_insertion(entry, {novelty, unsatisfied_goals, g});
        hadd_regular_open_list.do_insertion(entry, {h, g});
    }

    StateID get_top_node() {
        if (counter == NOVELTY_TURN) {
            counter = H_ADD_TURN;
            if ((priority > 0) and (not novelty_preferred_open_list.empty())) {
                priority--;
                return novelty_preferred_open_list.remove_min();
            } else {
                return novelty_regular_open_list.remove_min();
            }
        } else {
            counter = NOVELTY_TURN;
            if ((priority > 0) and (not hadd_preferred_open_list.empty())) {
                priority--;
                return hadd_preferred_open_list.remove_min();
            } else {
                return hadd_regular_open_list.remove_min();
            }
        }
    }

    void boost_priority(int inc) {
        priority += inc;
    }

    bool empty() {
        return (novelty_preferred_open_list.empty() and novelty_regular_open_list.empty()
            and hadd_preferred_open_list.empty() and hadd_regular_open_list.empty());
    }

};

template<class PackedStateT>
utils::ExitCode AlternatedBFWS<PackedStateT>::search(const Task &task,
                                                     SuccessorGenerator &generator,
                                                     Heuristic &heuristic) {
    
    double thesis_time = 0.0;
    double thesis_initial_succ = 0.0;
    double cleanup_time = 0.0;

    cout << "Starting AlternatedBFWS" << endl;
    clock_t timer_start = clock();
    StatePackerT packer(task);

    Goalcount gc;

    size_t number_goal_conditions = task.get_goal().goal.size() + task.get_goal().positive_nullary_goals.size() + task.get_goal().negative_nullary_goals.size();
    size_t number_relevant_atoms;

    std::unique_ptr<Heuristic> delete_free_h(HeuristicFactory::create_delete_free_heuristic(heuristic_type, task));

    atom_counter = initialize_counter_with_useful_atoms(task, *delete_free_h);
    number_relevant_atoms = atom_counter.get_total_number_of_atoms();

    AlternatedOpenListManager open_list;

    phmap::flat_hash_map<int, NodeNovelty> map_state_to_evaluators;

    SearchNode& root_node = space.insert_or_get_previous_node(packer.pack(task.initial_state),
                                                              LiftedOperatorId::no_operator, StateID::no_state);
    utils::Timer t;

    StandardNovelty novelty_evaluator(task, number_goal_conditions, number_relevant_atoms, width);

    int gc_h0 = gc.compute_heuristic(task.initial_state, task);

    int unachieved_atoms_s0 = 0;
    int novelty_value = novelty_evaluator.compute_novelty(task, task.initial_state, gc_h0, unachieved_atoms_s0);

    statistics.inc_evaluations();
    cout << "Initial heuristic value " << heuristic_layer << endl;
    int initial_h = delete_free_h->compute_heuristic(task.initial_state, task);

    GenericDynamicSearchSetup dynamic_setup(task, this->thesis_enabled);

    statistics.report_f_value_progress(initial_h);
    root_node.open(0, initial_h);
    open_list.do_insertion(root_node.state_id,
                           initial_h,
                           0,
                           gc_h0,
                           novelty_value,
                           false);

    map_state_to_evaluators.insert({root_node.state_id.id(), NodeNovelty(gc_h0, unachieved_atoms_s0)});

    if (check_goal(task, generator, timer_start, task.initial_state, root_node, space, thesis_time, thesis_initial_succ, dynamic_setup.dynamic_state_memory.at(0), cleanup_time)) return utils::ExitCode::SUCCESS;

    int heuristic_layer = initial_h;
    while (not open_list.empty()) {
        StateID sid = open_list.get_top_node();
        SearchNode &node = space.get_node(sid);
        int g = node.g;
        if (node.status == SearchNode::Status::CLOSED) {
            continue;
        }
        node.close();
        statistics.inc_expanded();

        assert(sid.id() >= 0 && (unsigned) sid.id() < space.size());
        DBState state = packer.unpack(space.get_state(sid));

        int h = delete_free_h->compute_heuristic(state, task);
        statistics.report_f_value_progress(g+h);
        node.update_h(h);

        int unsatisfied_goal_parent = map_state_to_evaluators.at(sid.id()).unsatisfied_goals;
        int unsatisfied_relevant_atoms_parent = map_state_to_evaluators.at(sid.id()).unsatisfied_relevant_atoms;

        if (h < heuristic_layer) {
            heuristic_layer = h;
            open_list.boost_priority(1000);
            cout << "New heuristic value expanded: h=" << h
                 << " [expansions: " << statistics.get_expanded()
                 << ", evaluations: " << statistics.get_evaluations()
                 << ", generations: " << statistics.get_generated()
                 << ", time: " << double(clock() - timer_start) / CLOCKS_PER_SEC << "]" << '\n';
        }

        //Get the thesis object that belongs to the state from the queue
        DynamicState old_dynamic_state = dynamic_setup.dynamic_state_memory.at(sid.id());
        //remove the thesis object from memory
        dynamic_setup.dynamic_state_memory.erase(sid.id());

        double time_clean = clock();
        //dynamic_setup.clean_state_memory(h);
        old_dynamic_state.cleanup_time += double(clock()-time_clean);

        //if the parent state tables have been cleaned up
        if(dynamic_setup.join_table_memory.count(old_dynamic_state.get_parent_state_id()) == 0){
            dynamic_setup.enable_block();
        }

        
        std::vector<std::vector<DynamicTables>> join_table_at_state;
        std::vector<std::vector<DynamicTables>> semijoin_table_at_state;
        if(!dynamic_setup.block_status()){
            //get all hash tables that were computed in the previous state
            join_table_at_state = dynamic_setup.join_table_memory.at(old_dynamic_state.get_parent_state_id());
            join_table_at_state.resize(task.get_action_schemas().size());
            semijoin_table_at_state = dynamic_setup.semijoin_table_memory.at(old_dynamic_state.get_parent_state_id());
            semijoin_table_at_state.resize(task.get_action_schemas().size());
            if(sid.id()!=0){
                dynamic_setup.semijoin_table_memory.insert_or_assign(sid.id(),semijoin_table_at_state);
                dynamic_setup.join_table_memory.insert_or_assign(sid.id(), join_table_at_state);
            }
        }

        //compute the difference to the previous states
        double time_delta = clock();
        if(this->thesis_enabled && sid.id()!=0 && !dynamic_setup.block_status()){
            std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> predicate_to_add_diff;
            std::unordered_map<int,bool> diff_delete;

            dynamic_setup.state_delta(task, old_dynamic_state, predicate_to_add_diff, diff_delete);
        }
        old_dynamic_state.delta_time += double(clock() - time_delta);
        
        
        for (const auto& action:task.get_action_schemas()) {

            DBState old_state;

            time_t thesis_timer = clock();
            time_t thesis_initial_timer = clock();
            old_dynamic_state.old_indices = dynamic_setup.old_indices_gblhack;

            
            auto applicable = generator.get_applicable_actions(action, state,task, old_dynamic_state,
                                join_table_at_state,semijoin_table_at_state,old_state, !dynamic_setup.block_status());
            
            
            //Sort the instantiations by their hash
            //Maybe think about this. Now that we know that the algo works correctly, we can maybe remove this
            std::sort(applicable.begin(),applicable.end());
            
            thesis_time += clock() - thesis_timer;
            if(sid.id()==0){
                thesis_initial_succ += clock() - thesis_initial_timer;
            }

            if(this->thesis_enabled && !dynamic_setup.block_status() ){
                //Save the new dynamic tables that were generated through the applocable actions calculation
                dynamic_setup.semijoin_table_memory.at(sid.id()).at(action.get_index()) = std::move(semijoin_table_at_state.at(action.get_index()));
                dynamic_setup.join_table_memory.at(sid.id()).at(action.get_index()) = std::move(join_table_at_state.at(action.get_index()));
                dynamic_setup.old_indices_gblhack = old_dynamic_state.old_indices;
            }
            
            
            statistics.inc_generated(applicable.size());


            for (const LiftedOperatorId& op_id:applicable) {
                
                //Create one new Thesis object per state
                DynamicState dynamic_successor(false,action);
                
                dynamic_successor.set_parent_state_id(sid.id());
                dynamic_successor.action_id = action.get_index();
                dynamic_successor.set_instantiation(op_id.get_instantiation());

                dynamic_setup.time_tracking(dynamic_successor, old_dynamic_state);

                dynamic_successor.old_indices = old_dynamic_state.old_indices;
                
                
                DBState s = generator.generate_successor(op_id, action, state, &dynamic_successor);

                bool is_preferred = is_useful_operator(task, s, delete_free_h->get_useful_atoms());
                int dist = g + action.get_cost();
                int unsatisfied_goals = gc.compute_heuristic(s, task);
                int unsatisfied_relevant_atoms = 0;

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

                auto& child_node = space.insert_or_get_previous_node(packer.pack(s), op_id, node.state_id);
                if (child_node.status==SearchNode::Status::NEW) {
                    // Inserted for the first time in the map
                    child_node.open(dist, h);
                    if (check_goal(task, generator, timer_start, s, child_node, space, thesis_time, thesis_initial_succ, old_dynamic_state, cleanup_time))
                        return utils::ExitCode::SUCCESS;
                    open_list.do_insertion(child_node.state_id,
                                           h,
                                           dist,
                                           unsatisfied_goals,
                                           novelty_value,
                                           is_preferred);
                    map_state_to_evaluators.insert({child_node.state_id.id(), NodeNovelty(unsatisfied_goals, unsatisfied_relevant_atoms)});

                    dynamic_setup.dynamic_state_memory.insert({child_node.state_id.id(),dynamic_successor});

                    //create a new empty join_table memory for the new state
                    std::vector<std::vector<Table>> thesis_join_at_state;
                    std::vector<std::vector<Table>> thesis_semijoin_at_state;
                    //remember that sid is the parent state of the current child node
                    dynamic_setup.dynamic_previous_state.insert_or_assign(child_node.state_id,sid);
                
                } else {
                    if (dist < child_node.g) {
                        child_node.open(dist, h); // Reopening
                        statistics.inc_reopened();
                        open_list.do_insertion(child_node.state_id,
                                               h,
                                               dist,
                                               unsatisfied_goals,
                                               novelty_value,
                                               is_preferred);
                    
                    dynamic_setup.dynamic_state_memory.insert_or_assign(child_node.state_id.id(),dynamic_successor);

                    //create a new empty join_table memory for the new state
                    std::vector<std::vector<Table>> thesis_join_at_state;
                    std::vector<std::vector<Table>> thesis_semijoin_at_state;
                    //remember that sid is the parent state of the current child node
                    dynamic_setup.dynamic_previous_state.insert_or_assign(child_node.state_id,sid);
                    
                    }
                }
            }
        }
        
        //Save which tables are associated with which heuristic value
        //If the heuristic improves some amount we remove the old tables

        if(this->thesis_enabled && !dynamic_setup.block_status()){
            if(dynamic_setup.heuristic_map.count(h) == 0){
                //std::cout << "enter1 \n";

                std::vector<std::pair<GenericDynamicSearchSetup::memory_table::iterator, int>> dummy;
                GenericDynamicSearchSetup::memory_table::iterator it1 = dynamic_setup.semijoin_table_memory.find(sid.id());
                GenericDynamicSearchSetup::memory_table::iterator it2 = dynamic_setup.join_table_memory.find(sid.id());
                dummy.push_back(std::make_pair(it1,0));
                dummy.push_back(std::make_pair(it2,1));

                dynamic_setup.heuristic_map.insert_or_assign(h, dummy);
            }else{
                //std::cout << "enter2 \n";
                dynamic_setup.heuristic_map.at(h).push_back(std::make_pair(dynamic_setup.semijoin_table_memory.find(sid.id()),0));
                dynamic_setup.heuristic_map.at(h).push_back(std::make_pair(dynamic_setup.join_table_memory.find(sid.id()),1));
            }
        }
        dynamic_setup.disable_block();
    }

    print_no_solution_found(timer_start, thesis_time, thesis_initial_succ);

    return utils::ExitCode::SEARCH_UNSOLVABLE;

}

template <class PackedStateT>
void AlternatedBFWS<PackedStateT>::print_statistics() const {
    statistics.print_detailed_statistics();
    space.print_statistics();
}


template<class PackedStateT>
AtomCounter AlternatedBFWS<PackedStateT>::initialize_counter_with_gc(const Task &task) {
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
AtomCounter AlternatedBFWS<PackedStateT>::initialize_counter_with_useful_atoms(const Task &task,
                                                                               Heuristic &delete_free_h) const {
    std::vector<std::vector<GroundAtom>> atoms(task.initial_state.get_relations().size(), std::vector<GroundAtom>());
    std::unordered_set<int> positive = task.get_goal().positive_nullary_goals;
    std::unordered_set<int> negative = task.get_goal().negative_nullary_goals;

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
template class AlternatedBFWS<SparsePackedState>;
template class AlternatedBFWS<ExtensionalPackedState>;

