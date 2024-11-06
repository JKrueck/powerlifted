#include "dynamic_successor_generator.h"

void GenericDynamicSearchSetup::state_delta(const Task& task, DynamicState& old, std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>>& predicate_to_add_diff, std::unordered_map<int,bool>& diff_delete){

    old.set_status(true);
   

    //Go trough all effects of the last applied action
    for(auto thesis_effects:task.get_action_schema_by_index(old.get_action_id()).get_effects()){
        //If it is a delete effect
        if(thesis_effects.is_negated()){
            //Insert the predicate of the delete effect
            diff_delete.insert_or_assign(thesis_effects.get_predicate_symbol_idx(),true);
            std::vector<int> thesis_deleted_fact;
            for(auto arg:thesis_effects.get_arguments()){
                thesis_deleted_fact.push_back(old.get_instantiation().at(arg.get_index()));
            }
            //Save the deleted facts of the corresponding predicate
            old.deleted_facts[thesis_effects.get_predicate_symbol_idx()].insert(thesis_deleted_fact);
        }else{
            GroundAtom thesis_add_effect;
            for(auto thesis_argument_it:thesis_effects.get_arguments()){
                thesis_add_effect.push_back(old.get_instantiation().at(thesis_argument_it.get_index()));
            }
            //Save the added facts of the corresponding predicate
            predicate_to_add_diff[thesis_effects.get_predicate_symbol_idx()].insert(thesis_add_effect);
        }
    }
    old.set_add_effect_map(predicate_to_add_diff);
    old.set_delete_effect_map(diff_delete);
};

void GenericDynamicSearchSetup::time_tracking(DynamicState& dynamic_successor, DynamicState& old_dynamic_state){
    
    dynamic_successor.counter_me = old_dynamic_state.counter_me;
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
    dynamic_successor.max_succ_time_normal = old_dynamic_state.max_succ_time_normal;
};

void GenericDynamicSearchSetup::clean_state_memory(int current_heuristic){
    //std::cout << "enter3 \n";
    if(this->heuristic_map.count(current_heuristic+2)!=0){
        if(this->heuristic_map.at(current_heuristic+2).size()!=0){
            while(this->heuristic_map.at(current_heuristic+2).size()!=0){
                auto pointer = this->heuristic_map.at(current_heuristic+2).back();
                pointer->clear();
                this->heuristic_map.at(current_heuristic+2).pop_back();
            }
        }
    }
    //std::cout << "exit3\n";
   
}