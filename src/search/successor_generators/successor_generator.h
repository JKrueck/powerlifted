#ifndef SEARCH_SUCCESSOR_GENERATOR_H
#define SEARCH_SUCCESSOR_GENERATOR_H

#include <vector>
#include <unordered_set>
#include <unordered_map>

#include "../states/state.h"
#include "../database/table.h"
#include "../database/utils.h"
#include "../structures.h"
#include "../action_schema.h"



// A few forward declarations :-)
class ActionSchema;
class DBState;
class LiftedOperatorId;

class Task;
class Table;


/* TODO:
*/

struct ThesisSave{
    std::unordered_map<std::vector<int>, std::unordered_set<std::vector<int>,TupleHash>, TupleHash> pos1_hashtable;
    std::unordered_map<std::vector<int>, std::unordered_set<std::vector<int>,TupleHash>, TupleHash> pos2_hashtable;
    
    std::unordered_map<std::vector<int>, std::unordered_set<std::vector<int>,TupleHash>, TupleHash> result_table;
    Table result;
    std::vector<int> result_index;

    //First:=order.second; Second:=order.first
    std::vector<std::pair<int,int>> matching_columns;

    std::unordered_set<std::vector<int>,TupleHash> pos1_deleted;
    std::unordered_set<std::vector<int>,TupleHash> pos1_added;
    //Only needed for Join Step Computation
    std::unordered_set<std::vector<int>,TupleHash> pos2_deleted;
    std::unordered_set<std::vector<int>,TupleHash> pos2_added;

    std::unordered_set<std::vector<int>,TupleHash> result_deleted;
    std::unordered_set<std::vector<int>,TupleHash> result_deleted_single;
    std::unordered_set<std::vector<int>,TupleHash> result_deleted_static;
    bool del_res = false;

    std::unordered_set<std::vector<int>,TupleHash> result_added;

    bool join_changed_size_first = false;
    bool join_changed_size_second = false;

    std::vector<Atom> static_pre_deletes;

    bool check_static = false;


    ThesisSave() = default;

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

    ThesisSave* refresh_tables(){
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

class ThesisClass
{

private:
    bool thesis_enable;
    //It should be an option to not save the whole state but use the dedicated state unpacker of powerlifted
    //DBState last_state;
    int parent_state_id;
    
    //added and deleted atoms in comparison to the parent state of this object
    std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> thesis_add_effect_map;
    std::unordered_map<int,bool> thesis_delete_effects;
    std::vector<int> thesis_instantiation;

public:
    std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> deleted_facts;
    int action_id;

    std::vector<std::unordered_map<int, std::vector<int>>> old_indices;

    ThesisClass(bool enable, ActionSchema act) :   thesis_enable(enable),action_id(act.get_index())
    {}

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




    int counter_weirdCase = 0;
    int counter_det_changeCross = 0;
    int counter_recomputeKeys = 0;
    int counter_weirdJoin = 0;


    int counter_me = 0;
    int counter_normal = 0;

    //ThesisClass() = default;
        
   
    //~ThesisClass();

    void set_add_effect_map(std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> map){
        this->thesis_add_effect_map = std::move(map);
    }

    std::unordered_map<int,std::unordered_set<GroundAtom,TupleHash>> get_add_effect_map(){
        return this->thesis_add_effect_map;
    }

    void set_delete_effects(std::unordered_map<int,bool> del_eff){
        this->thesis_delete_effects = std::move(del_eff);
    }

    std::unordered_map<int,bool>  get_del_eff(){
        return this->thesis_delete_effects;
    }


    void set_parent_state_id(int id){
        this->parent_state_id = id;
    }

    int get_parent_state_id(){
        return this->parent_state_id;
    }

    /*void set_action(ActionSchema action){
        this->last_action = action;
    }*/

    int get_action_id(){
        return this->action_id;
    }

    bool is_enabled() const{
        return thesis_enable;
    }

    void set_status(bool status){
        this->thesis_enable = status;
    }

    void set_instantiation(const std::vector<int>& inst){
        for(auto it:inst){
            thesis_instantiation.push_back(it);
        }
    }

    std::vector<int> get_instantiation(){
        return thesis_instantiation;
    }
            

};



typedef DBState StaticInformation;

/**
 * This base class implements a join-successor using the join of all positive preconditions in the
 * action schema.
 *
 * @attention Note that successor generators might change the number of generated states. This happens simply because
 * the order of the arguments produced differs depending on the order of the joins.
 *
 */
class SuccessorGenerator {

public:
    virtual ~SuccessorGenerator() = default;

    std::vector<std::pair<int, std::vector<int>>> added_atoms;


    /**
     * Compute the instantiations of the given action schema that are applicable in
     * the given state.
     *
     * @param action: The action schema
     * @param state: The state on which we want to compute applicability
     * @return A vector of IDs representing each of them a single applicable
     * instantiation of the action schema.
     */
    virtual std::vector<LiftedOperatorId> get_applicable_actions(
            const ActionSchema &action, const DBState &state,const Task &task, ThesisClass &thesis, std::vector<std::vector<ThesisSave>> &thesis_tables, std::vector<std::vector<ThesisSave>> &thesis_semijoin, DBState &old_state) = 0;

    /**
     * Generate the state that results from applying the given action to the given state.
     */
    virtual DBState generate_successor(const LiftedOperatorId &op,
                               const ActionSchema& action,
                               const DBState &state,
                                ThesisClass *thes_class) = 0;

    void add_to_added_atoms(int i, const std::vector<int> & atom) {
        added_atoms.emplace_back(i, atom);
    }

    virtual const std::vector<std::pair<int, std::vector<int>>> &get_added_atoms() const {
        return added_atoms;
    }

};

#endif //SEARCH_SUCCESSOR_GENERATOR_H
