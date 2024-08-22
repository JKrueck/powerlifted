
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
    double thesis_time = 0.0;
    double thesis_init = 0.0;
    clock_t timer_start = clock();

    StatePackerT packer(task);
    std::queue<StateID> queue;

    SearchNode& root_node = space.insert_or_get_previous_node(packer.pack(task.initial_state), LiftedOperatorId::no_operator, StateID::no_state);
    root_node.open(0);
    cout << "Initial heuristic value 0" << endl;
    statistics.report_f_value_progress(root_node.f);
    queue.emplace(root_node.state_id);

    //Save the intermediate hash-join tables at a global level and per action
    std::vector<std::vector<ThesisSave>> thesis_join_table_at_state;
    thesis_join_table_at_state.resize(task.get_action_schemas().size());
    //As we always want to use the join tables from the prior state, we need to save all of them on a per state basis
    //To-Do: Think about when we don´t need them anymore and can delete them from memory
    std::map<int, std::vector<std::vector<ThesisSave>>> thesis_join_table_memory; 
    thesis_join_table_memory.insert({0,thesis_join_table_at_state});

    //Save the intermediate semi-join tables at a global level and per action
    std::vector<std::vector<ThesisSave>> thesis_semijoin_table_at_state;
    thesis_semijoin_table_at_state.resize(task.get_action_schemas().size());
    //As we always want to use the join tables from the prior state, we need to save all of them on a per state basis
    //To-Do: Think about when we don´t need them anymore and can delete them from memory
    std::map<int, std::vector<std::vector<ThesisSave>>> thesis_semijoin_table_memory;
    thesis_semijoin_table_memory.insert({0,thesis_semijoin_table_at_state});

    //Storage for classes per state
    //intended to work similar to queue
    std::map<int,ThesisClass> thesis_state_memory;
    ThesisClass initial = ThesisClass(true,task.get_action_schema_by_index(0));//this->thesis_enabled
    initial.set_parent_state_id(0);
    initial.old_indices.resize(task.get_action_schemas().size());
    thesis_state_memory.insert({0,initial});

    //saving what was the previous state globally and then using the packer to pass it to yannakakis instead of 
    //always saving the previous state in ThesisClass
    std::unordered_map<StateID,StateID,ThesisStateIDHasher> thesis_previous_state;
    thesis_previous_state.insert_or_assign(StateID::no_state, StateID::no_state);
    thesis_state_memory.insert({0,ThesisClass(false,task.get_action_schema_by_index(0))});

    std::unordered_set<int> currently_relevant;
    std::unordered_set<int> relevant_parents;
    std::unordered_map<int,int> parents_counter;
    currently_relevant.insert(0);

    std::vector<std::unordered_map<int, GroundAtom>> old_indices_gblhack;
    old_indices_gblhack.resize(task.get_action_schemas().size());

     if (check_goal(task, generator, timer_start, task.initial_state, root_node, space, thesis_time, thesis_init, thesis_state_memory.at(0))) return utils::ExitCode::SUCCESS;

    time_t intermediate = clock();
    while (not queue.empty()) {
        StateID sid = queue.front();
        queue.pop();
        SearchNode &node = space.get_node(sid);

        relevant_parents.insert(sid.id());
        currently_relevant.erase(sid.id());
        parents_counter.insert_or_assign(sid.id(),0);
        
        //Get the thesis object that belongs to the state from the queue
        ThesisClass old_thesis = thesis_state_memory.at(sid.id());
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

        thesis_join_table_at_state = thesis_join_table_memory.at(old_thesis.get_parent_state_id());
        std::vector<std::vector<ThesisSave>> thesis_semijoin_table_at_state = thesis_semijoin_table_memory.at(old_thesis.get_parent_state_id());
        thesis_semijoin_table_at_state.resize(task.get_action_schemas().size());
        if(sid.id()!=0){
            thesis_semijoin_table_memory.insert_or_assign(sid.id(),thesis_semijoin_table_at_state);
            thesis_join_table_memory.insert_or_assign(sid.id(), thesis_join_table_at_state);
        }

        if (check_goal(task, generator, timer_start, state, node, space, thesis_time, thesis_init, old_thesis)) return utils::ExitCode::SUCCESS;

        time_t thesis_timer = clock();
        if(this->thesis_enabled && sid.id()!=0){
            old_thesis.set_status(true);
            std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> predicate_to_add_diff;
            std::unordered_map<int,bool> diff_delete;
            for(auto thesis_effects:task.get_action_schema_by_index(old_thesis.get_action_id()).get_effects()){
                if(thesis_effects.is_negated()){
                    //GroundAtom thesis_delete_effect;
                    //for(auto thesis_argument_it:thesis_effects.get_arguments()){
                        //thesis_delete_effect.push_back(op_id.get_instantiation().at(thesis_argument_it.get_index()));
                    //}
                    
                    diff_delete.insert_or_assign(thesis_effects.get_predicate_symbol_idx(),true);
                    std::vector<int> thesis_deleted_fact;
                    for(auto arg:thesis_effects.get_arguments()){
                        thesis_deleted_fact.push_back(old_thesis.get_instantiation().at(arg.get_index()));
                    }
                    //old_thesis.deleted_facts.insert({thesis_effects.get_predicate_symbol_idx(),thesis_deleted_fact});
                    old_thesis.deleted_facts[thesis_effects.get_predicate_symbol_idx()].insert(thesis_deleted_fact);
                }else{
                    GroundAtom thesis_add_effect;
                    for(auto thesis_argument_it:thesis_effects.get_arguments()){
                        thesis_add_effect.push_back(old_thesis.get_instantiation().at(thesis_argument_it.get_index()));
                    }
                    //predicate_to_add_diff.insert({thesis_effects.get_predicate_symbol_idx(),thesis_set_storage});
                    predicate_to_add_diff[thesis_effects.get_predicate_symbol_idx()].insert(thesis_add_effect);
                }
            }
            thesis_time += clock() - thesis_timer;
            old_thesis.set_add_effect_map(predicate_to_add_diff);
            old_thesis.set_delete_effect_map(diff_delete);
        }






        // Let's expand the state, one schema at a time. If necessary, i.e. if it really helps
        // performance, we could implement some form of std iterator
        for (const auto& action : task.get_action_schemas()) {

  
        
            DBState old_state;
            if(sid.id()!= 0){
                old_state = packer.unpack(space.get_state(thesis_previous_state.at(sid)));
            }else{
                old_state = state;
            }
            time_t thesis_timer = clock();
            time_t thesis_initial_timer = clock();
            old_thesis.old_indices = old_indices_gblhack;
            auto applicable = generator.get_applicable_actions(action, state,task, old_thesis,
                                thesis_join_table_at_state,thesis_semijoin_table_at_state,old_state);

            //Sort the instantiations by their hash
            std::sort(applicable.begin(),applicable.end());
            
            thesis_time += clock() - thesis_timer;
            if(sid.id()==0){
                thesis_init += clock() - thesis_initial_timer;
            }
            thesis_semijoin_table_memory.at(sid.id()).at(action.get_index()) = std::move(thesis_semijoin_table_at_state.at(action.get_index()));
            thesis_join_table_memory.at(sid.id()).at(action.get_index()) = std::move(thesis_join_table_at_state.at(action.get_index()));

            old_indices_gblhack = old_thesis.old_indices;

            statistics.inc_generated(applicable.size());

            if(false){
                std::cout << "Number of instantiations of action " << action.get_name() << " : " << applicable.size() << endl;
                //if(applicable.size()!=0)
            
               
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

            for (const LiftedOperatorId &op_id:applicable) {

                
                if((clock()-intermediate)/CLOCKS_PER_SEC >= 10.0 && sid.id()!=0){
                    cout << "Intermediate Average Full Reducer time me: " << (old_thesis.fullreducer_time_me / old_thesis.counter_me)/CLOCKS_PER_SEC << endl;
                    cout << "Intermediate Average Full Reducer time normal: " << (old_thesis.fullreducer_time_normal / old_thesis.counter_normal)/CLOCKS_PER_SEC  << endl;
                    cout << "Intermediate Average Join Step time me: " << (old_thesis.joinstep_time_me / old_thesis.counter_me)/CLOCKS_PER_SEC  << endl;
                    cout << "Intermediate Average Join Step time normal: " << (old_thesis.joinstep_time_normal / old_thesis.counter_normal)/CLOCKS_PER_SEC  << endl;
                    intermediate = clock();
                }
                
                //Create one new Thesis object per state
                ThesisClass thesis_successor(false,action);
                
                
                thesis_successor.set_parent_state_id(sid.id());
                thesis_successor.action_id = action.get_index();
                thesis_successor.set_instantiation(op_id.get_instantiation());
                //Time tracking
                thesis_successor.counter_me = old_thesis.counter_me;
                thesis_successor.counter_normal = old_thesis.counter_normal;
                thesis_successor.fullreducer_time_me = old_thesis.fullreducer_time_me;
                thesis_successor.fullreducer_time_normal = old_thesis.fullreducer_time_normal;
                thesis_successor.joinstep_time_me = old_thesis.joinstep_time_me;
                thesis_successor.joinstep_time_normal = old_thesis.joinstep_time_normal;
                thesis_successor.time_tables_me = old_thesis.time_tables_me;
                thesis_successor.time_tables_normal = old_thesis.time_tables_normal;
                thesis_successor.join_time = old_thesis.join_time;
                thesis_successor.time_me = old_thesis.time_me;
                thesis_successor.time_normal = old_thesis.time_normal;
                


                thesis_successor.old_indices = old_thesis.old_indices;

                DBState s = generator.generate_successor(op_id, action, state, &thesis_successor);
                auto& child_node = space.insert_or_get_previous_node(packer.pack(s), op_id, node.state_id);
                if (child_node.status == SearchNode::Status::NEW) {
                    child_node.open(node.f+1);

                    if (check_goal(task, generator, timer_start, s, child_node, space, thesis_time, thesis_init, old_thesis)) return utils::ExitCode::SUCCESS;

                    queue.emplace(child_node.state_id);
                    currently_relevant.insert(child_node.state_id.id());
                    parents_counter[sid.id()]+=1;

                    thesis_state_memory.insert({child_node.state_id.id(),thesis_successor});

                    //create a new empty join_table memory for the new state
                    std::vector<std::vector<Table>> thesis_join_at_state;
                    thesis_join_at_state.resize(task.get_action_schemas().size());
                    //thesis_join_table_memory.insert({child_node.state_id.id(),thesis_join_table_at_state});
                    //create a new empty semijoin_table memory for the new state
                    std::vector<std::vector<Table>> thesis_semijoin_at_state;
                    thesis_semijoin_at_state.resize(task.get_action_schemas().size());
                    //thesis_semijoin_table_memory.insert({child_node.state_id.id(),thesis_semijoin_table_at_state});
                    //remember that sid is the parent state of the current child node
                    thesis_previous_state.insert_or_assign(child_node.state_id,sid);
                }
                
            }
        }
        if(sid.id()!=0) parents_counter[old_thesis.get_parent_state_id()]--;
        if(parents_counter[old_thesis.get_parent_state_id()]<=0){
            thesis_semijoin_table_memory.erase(old_thesis.get_parent_state_id());
            thesis_join_table_memory.erase(old_thesis.get_parent_state_id());
            //cout << "Removed obsolete parent from memory" << endl;
        } 
    }

    print_no_solution_found(timer_start, thesis_time, thesis_init);

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
