#ifndef DYNAMIC_SUCCESSOR_GENERATOR_H
#define DYNAMIC_SUCCESSOR_GENERATOR_H

#include <vector>
#include <unordered_set>
#include <unordered_map>

#include "../states/state.h"
#include "../database/table.h"
#include "../database/utils.h"
#include "../structures.h"
#include "../action_schema.h"

#include "../search_engines/nodes.h"

//Formerly ThesisSave
struct DynamicTables{
    std::unordered_map<std::vector<int>, std::unordered_set<std::vector<int>,TupleHash>, TupleHash> pos1_hashtable;
    std::unordered_map<std::vector<int>, std::unordered_set<std::vector<int>,TupleHash>, TupleHash> pos2_hashtable;
    
    std::unordered_map<std::vector<int>, std::unordered_set<std::vector<int>,TupleHash>, TupleHash> result_table;
    Table result;
    std::vector<int> result_index;

    //First:=order.second; Second:=order.first
    std::vector<std::pair<int,int>> matching_columns;
    //Facts deleted through the semi-join process
    std::unordered_set<std::vector<int>,TupleHash> pos1_deleted;
    std::unordered_set<std::vector<int>,TupleHash> pos1_added;
    
    //Only needed for Join Step Computation
    std::unordered_set<std::vector<int>,TupleHash> pos2_deleted;
    std::unordered_set<std::vector<int>,TupleHash> pos2_added;

    //Contains the del facts
    std::unordered_set<std::vector<int>,TupleHash> result_deleted;

    //Contains the deleted facts as they appear in the result -- possibly already larger than the del fact being considered
    std::unordered_set<std::vector<int>,TupleHash> result_deleted_single;
    std::unordered_set<std::vector<int>,TupleHash> result_deleted_static;
    //???
    bool del_res = false;

    std::unordered_set<std::vector<int>,TupleHash> result_added;

    //Joins can change the size of the tables
    bool join_changed_size_first = false;
    bool join_changed_size_second = false;

    std::vector<Atom> static_pre_deletes;
    bool check_static = false;


    DynamicTables() = default;

    Table generate_table(){
        this->result.tuples.clear();
        for(auto set:this->result_table){
            for(auto it:set.second){
                this->result.tuples.push_back(it);
            }
        }
        result.tuple_index = this->result_index;
        return this->result;
    }

    DynamicTables* refresh_tables(){
        this->pos1_added.clear();
        this->pos1_deleted.clear();
        this->pos2_added.clear();
        this->pos2_deleted.clear();
        this->result_deleted.clear();
        this->result_deleted_single.clear();
        this->result_added.clear();
        
        return this;
    }

};

//Formerly ThesisClass
class DynamicState
{

private:
    bool dynamic_enabled;
    
    int parent_state_id;
    
    //added and deleted atoms in comparison to the parent state of this object
    std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> add_effect_map;
    std::unordered_map<int,bool> delete_effects;
    std::vector<int> instantiation;

public:

    DynamicState(bool enable, ActionSchema act) :   dynamic_enabled(enable),action_id(act.get_index())
    {}

    //Statistics
    double fullreducer_time_me = 0.0;
    double fullreducer_time_normal = 0.0;
    double max_fullreducer_me = 0.0;
    double max_fullreducer_normal = 0.0;
    double min_fullreducer_me = 1000000.0;
    double min_fullreducer_normal = 10000000.0;
    double joinstep_time_me = 0.0;
    double joinstep_time_normal = 0.0;
    double crossproduct_time = 0.0;
    double join_time = 0.0;
    double max_join_me = 0.0;
    double max_join_normal = 0.0;
    double time_me = 0.0;
    double time_normal = 0.0;

    double time_tables_me = 0.0;
    double time_tables_normal = 0.0;


    double max_succ_time_me = 0.0;
    double max_succ_time_normal = 0.0;


    int counter_me = 0;
    int counter_normal = 0;

    
    std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> deleted_facts;
    int action_id;

    std::vector<std::unordered_map<int, std::vector<int>>> old_indices;

    void set_add_effect_map(std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> map){
        this->add_effect_map = std::move(map);
    }

    std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> get_add_effect_map(){
        return this->add_effect_map;
    }

    void set_delete_effect_map(std::unordered_map<int,bool> del_eff){
        this->delete_effects = std::move(del_eff);
    }

    std::unordered_map<int,bool>  get_del_eff(){
        return this->delete_effects;
    }


    void set_parent_state_id(int id){
        this->parent_state_id = id;
    }

    int get_parent_state_id(){
        return this->parent_state_id;
    }

    int get_action_id(){
        return this->action_id;
    }

    bool is_enabled() const{
        return dynamic_enabled;
    }

    //Enable or disable dynamic successor generation
    void set_status(bool status){
        this->dynamic_enabled= status;
    }

    void set_instantiation(const std::vector<int>& inst){
        for(auto it:inst){
            instantiation.push_back(it);
        }
    }

    std::vector<int> get_instantiation(){
        return instantiation;
    }
            

};

class GenericDynamicSearchSetup{
public:
    using memory_table = std::unordered_map<int, std::vector<std::vector<DynamicTables>>>;

    std::vector<std::vector<DynamicTables>> join_table_per_state;
    memory_table join_table_memory; 
    std::vector<std::vector<DynamicTables>> semijoin_table_first_state;
    std::vector<std::vector<DynamicTables>> join_table_first_state;
    memory_table semijoin_table_memory;
    std::unordered_map<int,DynamicState> dynamic_state_memory;
    std::vector<std::unordered_map<int, GroundAtom>> old_indices_gblhack;
    std::unordered_map<StateID,StateID,ThesisStateIDHasher> dynamic_previous_state;

    std::unordered_map<int, std::vector<std::vector<std::vector<DynamicTables>>*>> heuristic_map;

    GenericDynamicSearchSetup(Task task, bool enable){

        //Save the intermediate hash-join tables at a global level and per action
        this->join_table_first_state.resize(task.get_action_schemas().size());
        //As we always want to use the join tables from the prior state, we need to save all of them on a per state basis
        this->join_table_memory.insert({0,this->join_table_first_state});

        //Save the intermediate semi-join tables at a global level and per action
        this->semijoin_table_first_state.resize(task.get_action_schemas().size());
        //As we always want to use the join tables from the prior state, we need to save all of them on a per state basis
        this->semijoin_table_memory.insert({0,this->semijoin_table_first_state});

        //Storage for classes per state
        //intended to work similar to queue
        DynamicState initial = DynamicState(enable,task.get_action_schema_by_index(0));
        initial.set_parent_state_id(0);
        initial.old_indices.resize(task.get_action_schemas().size());
        this->dynamic_state_memory.insert({0,initial});

        
        this->old_indices_gblhack.resize(task.get_action_schemas().size());

        //saving what was the previous state globally and then using the packer to pass it to yannakakis instead of 
        //always saving the previous state in DynamicState
        
        this->dynamic_previous_state.insert_or_assign(StateID::no_state, StateID::no_state);
    };

    void state_delta(const Task& task, DynamicState& old, std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>>& predicate_to_add_diff, std::unordered_map<int,bool>& diff_delete);
    void time_tracking(DynamicState& dynamic_successor, DynamicState& old_dynamic_state);
    void clean_state_memory(int current_heuristic);

};

#endif