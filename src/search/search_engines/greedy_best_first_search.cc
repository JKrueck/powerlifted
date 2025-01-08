#include "greedy_best_first_search.h"
#include "search.h"
#include "utils.h"

#include "../action.h"

#include "../heuristics/heuristic.h"
#include "../open_lists/greedy_open_list.h"
#include "../states/extensional_states.h"
#include "../states/sparse_states.h"
#include "../successor_generators/successor_generator.h"
#include "../utils/timer.h"

#include <algorithm>
#include <iostream>
#include <queue>
#include <vector>

using namespace std;

template <class PackedStateT>
utils::ExitCode GreedyBestFirstSearch<PackedStateT>::search(const Task &task,
                                                SuccessorGenerator &generator,
                                                Heuristic &heuristic)
{   
    double thesis_time = 0.0;
    double thesis_initial_succ = 0.0;
    double cleanup_time = 0.0;
    cout << "Starting greedy best first search" << endl;
    clock_t timer_start = clock();
    StatePackerT packer(task);

    bool skip = true;

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
    queue.do_insertion(root_node.state_id, make_pair(heuristic_layer, 0));


    GenericDynamicSearchSetup dynamic_setup(task, this->thesis_enabled);
    /*//Save the intermediate hash-join tables at a global level and per action
    std::vector<std::vector<DynamicTables>> dynamic_setup.join_table_per_state;
    dynamic_setup.join_table_per_state.resize(task.get_action_schemas().size());
    //As we always want to use the join tables from the prior state, we need to save all of them on a per state basis
    std::unordered_map<int, std::vector<std::vector<DynamicTables>>> dynamic_setup.join_table_memory; 
    dynamic_setup.join_table_memory.insert({0,dynamic_setup.join_table_per_state});

    //Save the intermediate semi-join tables at a global level and per action
    std::vector<std::vector<DynamicTables>> semijoin_table_at_state_first;
    semijoin_table_at_state_first.resize(task.get_action_schemas().size());
    //As we always want to use the join tables from the prior state, we need to save all of them on a per state basis
    std::unordered_map<int, std::vector<std::vector<DynamicTables>>> dynamic_setup.semijoin_table_memory;
    dynamic_setup.semijoin_table_memory.insert({0,semijoin_table_at_state_first});

    //Storage for classes per state
    //intended to work similar to queue
    std::unordered_map<int,DynamicState> dynamic_setup.dynamic_state_memory;
    DynamicState initial = DynamicState(true,task.get_action_schema_by_index(0));
    initial.set_parent_state_id(0);
    initial.old_indices.resize(task.get_action_schemas().size());
    dynamic_setup.dynamic_state_memory.insert({0,initial});

    std::vector<std::unordered_map<int, GroundAtom>> old_indices_gblhack;
    old_indices_gblhack.resize(task.get_action_schemas().size());

    //saving what was the previous state globally and then using the packer to pass it to yannakakis instead of 
    //always saving the previous state in DynamicState
    std::unordered_map<StateID,StateID,ThesisStateIDHasher> dynamic_setup.dynamic_previous_state;
    dynamic_setup.dynamic_previous_state.insert_or_assign(StateID::no_state, StateID::no_state);*/

    std::unordered_map<int,std::vector<int>> test_map;


    if (check_goal(task, generator, timer_start, task.initial_state, root_node, space, thesis_time, thesis_initial_succ, dynamic_setup.dynamic_state_memory.at(0), cleanup_time)) return utils::ExitCode::SUCCESS;

    time_t intermediate = clock();
    while (not queue.empty()) {
        StateID sid = queue.remove_min();
        SearchNode &node = space.get_node(sid);

        //cout << "----current state: " << sid.id() << "----" << endl;

        if(sid.id()!=0){
            skip = false;
        }

        int h = node.h;
        int g = node.g;
        if (node.status == SearchNode::Status::CLOSED) {
            continue;
        }
        node.close();
        statistics.report_f_value_progress(h); // In GBFS f = h.
        statistics.inc_expanded();

        
        double time_clean = clock();
        if(this->thesis_enabled) dynamic_setup.clean_state_memory(h);
        cleanup_time += double(clock()-time_clean);

        bool print = false;
        if(sid.id()==0){
            print = true;
        }
        
        if (h < heuristic_layer) {
            heuristic_layer = h;
            cout << "New heuristic value expanded: h=" << h
                 << " [expansions: " << statistics.get_expanded()
                 << ", evaluations: " << statistics.get_evaluations()
                 << ", generations: " << statistics.get_generated()
                 << ", state " << sid.id()
                 << ", succ time: " << thesis_time / CLOCKS_PER_SEC
                 << ", time: " << double(clock() - timer_start) / CLOCKS_PER_SEC << "]" << '\n';
            print = true;    
        }
        assert(sid.id() >= 0 && (unsigned) sid.id() < space.size());
        DBState state = packer.unpack(space.get_state(sid));

        //Get the thesis object that belongs to the state from the queue
        DynamicState old_dynamic_state = dynamic_setup.dynamic_state_memory.at(sid.id());
        //remove the thesis object from memory
        dynamic_setup.dynamic_state_memory.erase(sid.id());

        //if the parent state tables have been cleaned up
        if(dynamic_setup.join_table_memory.count(old_dynamic_state.get_parent_state_id()) == 0){
            dynamic_setup.enable_block();
        }

        if(sid.id() != 0) {//sid.id() != 0 && sid.id()<130
            cout << "parent state: " << old_dynamic_state.get_parent_state_id() << endl;
            cout << "action used to get here: " << old_dynamic_state.get_action_id() << "->" << task.get_action_schema_by_index(old_dynamic_state.get_action_id()).get_name()<< endl;
            cout << "with instantiation: ";
            for (auto it:test_map.at(sid.id())){
                cout << it << " ";
            }
            cout << endl;
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
        


       
        if (check_goal(task, generator, timer_start, state, node, space, thesis_time, thesis_initial_succ, old_dynamic_state, cleanup_time)){
            cout << "Size of semijoin memory: " << dynamic_setup.semijoin_table_memory.size() << endl;
            return utils::ExitCode::SUCCESS;
        } 

        if(this->thesis_enabled && sid.id()!=0 && !dynamic_setup.block_status()){
            std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> predicate_to_add_diff;
            std::unordered_map<int,bool> diff_delete;

            dynamic_setup.state_delta(task, old_dynamic_state, predicate_to_add_diff, diff_delete);

            /*//Go trough all effects of the last applied action
            for(auto thesis_effects:task.get_action_schema_by_index(old_dynamic_state.get_action_id()).get_effects()){
                //If it is a delete effect
                if(thesis_effects.is_negated()){
                    //Insert the predicate of the delete effect
                    diff_delete.insert_or_assign(thesis_effects.get_predicate_symbol_idx(),true);
                    std::vector<int> thesis_deleted_fact;
                    for(auto arg:thesis_effects.get_arguments()){
                        thesis_deleted_fact.push_back(old_dynamic_state.get_instantiation().at(arg.get_index()));
                    }
                    //Save the deleted facts of the corresponding predicate
                    old_dynamic_state.deleted_facts[thesis_effects.get_predicate_symbol_idx()].insert(thesis_deleted_fact);
                }else{
                    GroundAtom thesis_add_effect;
                    for(auto thesis_argument_it:thesis_effects.get_arguments()){
                        thesis_add_effect.push_back(old_dynamic_state.get_instantiation().at(thesis_argument_it.get_index()));
                    }
                    //Save the added facts of the corresponding predicate
                    predicate_to_add_diff[thesis_effects.get_predicate_symbol_idx()].insert(thesis_add_effect);
                }
            }
            old_dynamic_state.set_add_effect_map(predicate_to_add_diff);
            old_dynamic_state.set_delete_effect_map(diff_delete);*/
        }


        // Let's expand the state, one schema at a time. If necessary, i.e. if it really helps
        // performance, we could implement some form of std iterator
        for (const auto& action:task.get_action_schemas()) {

            if (sid.id()==8) {
                if(action.get_index()==17){
                   int stop13 = 5;
                }
            }

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
            if(false){
                //Number of instantiations of action 
                if(applicable.size()!=0)//
                    std::cout << "" << action.get_name() << " " << action.get_index() << " : " << applicable.size() << endl;
                if(false){//sid.id()!=0
                    cout << "instantiations: "<< endl;
                    for(auto it:applicable){
                        cout << "\t";
                        for(auto it2:it.get_instantiation()){
                            cout << it2 << " ";
                        }  
                        cout << endl;
                    }
                }
            }

            statistics.inc_generated(applicable.size());
            
            for (const LiftedOperatorId& op_id:applicable) {
                //Create one new Thesis object per state
                DynamicState dynamic_successor(false,action);
                
                
                dynamic_successor.set_parent_state_id(sid.id());
                dynamic_successor.action_id = action.get_index();
                dynamic_successor.set_instantiation(op_id.get_instantiation());

                dynamic_setup.time_tracking(dynamic_successor, old_dynamic_state);

                //Time tracking
                /*dynamic_successor.counter_me = old_dynamic_state.counter_me;
                dynamic_successor.counter_normal = old_dynamic_state.counter_normal;
                dynamic_successor.fullreducer_time_me = old_dynamic_state.fullreducer_time_me;
                dynamic_successor.fullreducer_time_normal = old_dynamic_state.fullreducer_time_normal;
                dynamic_successor.joinstep_time_me = old_dynamic_state.joinstep_time_me;
                dynamic_successor.joinstep_time_normal = old_dynamic_state.joinstep_time_normal;
                dynamic_successor.time_tables_me = old_dynamic_state.time_tables_me;
                dynamic_successor.time_tables_normal = old_dynamic_state.time_tables_normal;
                dynamic_successor.join_time = old_dynamic_state.join_time;
                dynamic_successor.time_me = old_dynamic_state.time_me;
                dynamic_successor.time_normal = old_dynamic_state.time_normal;
                dynamic_successor.max_fullreducer_me = old_dynamic_state.max_fullreducer_me;
                dynamic_successor.max_fullreducer_normal = old_dynamic_state.max_fullreducer_normal;
                dynamic_successor.min_fullreducer_me = old_dynamic_state.min_fullreducer_me;
                dynamic_successor.min_fullreducer_normal = old_dynamic_state.min_fullreducer_normal;
                dynamic_successor.crossproduct_time = old_dynamic_state.crossproduct_time;
                dynamic_successor.max_join_me = old_dynamic_state.max_join_me;
                dynamic_successor.max_join_normal = old_dynamic_state.max_join_normal;

                dynamic_successor.max_succ_time_me = old_dynamic_state.max_succ_time_me;
                dynamic_successor.max_succ_time_normal = old_dynamic_state.max_succ_time_normal;*/

                dynamic_successor.old_indices = old_dynamic_state.old_indices;

                DBState s = generator.generate_successor(op_id, action, state, &dynamic_successor);
                auto& child_node = space.insert_or_get_previous_node(packer.pack(s), op_id, node.state_id);

                if(child_node.state_id.id()==11){
                    int stop134 = 0;
                }

                /*if(child_node.state_id.id()!=1){
                    if(child_node.state_id.id()!=14){
                        if(child_node.state_id.id()!=19){
                            if(child_node.state_id.id()!=32){
                                    if(child_node.state_id.id()!=60){
                                        if((child_node.state_id.id()!=111 )){
                                            if(child_node.state_id.id()!=114){
                                                continue;
                                            }
                                            
                                        }
                                    }
                                }
                            }       
                    }
                }*/

                int dist = g + action.get_cost();
                int new_h = heuristic.compute_heuristic(s, task);
                statistics.inc_evaluations();


                test_map.insert({child_node.state_id.id(),op_id.get_instantiation()});
                
                if (new_h == UNSOLVABLE_STATE) {
                    if (child_node.status == SearchNode::Status::NEW) {
                        // Only increase statistics for new dead-ends
                        child_node.open(dist, new_h);
                        statistics.inc_dead_ends();
                        statistics.inc_pruned_states();

                        dynamic_setup.dynamic_state_memory.insert({child_node.state_id.id(),dynamic_successor});
                        //remember that sid is the parent state of the current child node
                        dynamic_setup.dynamic_previous_state.insert_or_assign(child_node.state_id,sid);
                    }
                    continue;
                }
                if (child_node.status == SearchNode::Status::NEW) {
                    // Inserted for the first time in the map
                    child_node.open(dist, new_h);
                    statistics.inc_evaluated_states();
                    queue.do_insertion(child_node.state_id, make_pair(new_h, dist));

                    dynamic_setup.dynamic_state_memory.insert({child_node.state_id.id(),dynamic_successor});

                    //create a new empty join_table memory for the new state
                    std::vector<std::vector<Table>> thesis_join_at_state;
                    std::vector<std::vector<Table>> thesis_semijoin_at_state;
                    //remember that sid is the parent state of the current child node
                    dynamic_setup.dynamic_previous_state.insert_or_assign(child_node.state_id,sid);

                    
                }
                else {
                    if (dist < child_node.g) {
                        child_node.open(dist, new_h); // Reopening
                        statistics.inc_reopened();
                        queue.do_insertion(child_node.state_id, make_pair(new_h, dist));

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
        //std::cout << "exit1 \n";
    }

    print_no_solution_found(timer_start, thesis_time, thesis_initial_succ);

    return utils::ExitCode::SEARCH_UNSOLVABLE;
}

template <class PackedStateT>
void GreedyBestFirstSearch<PackedStateT>::print_statistics() const {
    statistics.print_detailed_statistics();
    space.print_statistics();
}

// explicit template instantiations
template class GreedyBestFirstSearch<SparsePackedState>;
template class GreedyBestFirstSearch<ExtensionalPackedState>;
