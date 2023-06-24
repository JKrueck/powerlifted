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
    -deal with doubled action add effects



*/

class ThesisClass
{

private:
    //Storage for fully reduced tables
    std::vector<Table> thesis_initial_tables;
    //Storage for the results of the singular join steps
    std::vector<Table> thesis_join_tables;
    //Storage for the hash-join matches; per action
    std::vector<std::unordered_set<int>> thesis_match;
    //Storage of the grounded action add effects; store add effect per predicate
    std::vector<GroundAtom>diff;
    //Storage of the correspondence between tuple indices in the join tables and predicate index; per action
    std::vector<std::unordered_map<int,std::vector<int>>> predicate_tuple_indices;
    bool thesis_enable;
    ActionSchema last_action;
    int action_id;
    DBState last_state;
    
public:
    ThesisClass(bool enable, ActionSchema act) : thesis_enable(enable), last_action(act)
    {}
    ThesisClass(bool enable, ActionSchema act, DBState& s) : thesis_enable(enable), last_action(act), action_id(act.get_index()), last_state(s)
    {}

    //ThesisClass() = default;
        
   
    //~ThesisClass();

    void set_action(ActionSchema action){
        this->last_action = action;
    }

    int get_action_id(){
        return this->action_id;
    }

    std::vector<Table>* get_initial_tables(){
        return &this->thesis_initial_tables;
    }

    std::vector<Table>* get_join_tables(){
        return &this->thesis_join_tables;
    }

    std::vector<Table> get_tables_copy(){
        return this->thesis_initial_tables;
    }


    void insert_join_table(Table tab){
        this->thesis_join_tables.push_back(tab);
    }


    void set_initial_tables(std::vector<Table> tab){
        this->thesis_initial_tables = tab;
    }

    void set_join_tables(std::vector<Table> tab){
        this->thesis_join_tables = tab;
    }


    std::unordered_set<int>* get_matches_at_idx(int idx){
        return &this->thesis_match.at(idx);
    }

    //don´t now if the move is good here
    void insert_match(std::unordered_set<int> match){
        this->thesis_match.push_back(std::move(match));
    }

    const bool is_enabled(){
        return thesis_enable;
    }

    void set_diff( std::vector<GroundAtom> set_diff){
        this->diff = set_diff;
    }

    std::vector<GroundAtom>* get_diff(){
        return &this->diff;
    }

    void insert_tuple_indices(std::unordered_map<int,std::vector<int>> indices){
        this->predicate_tuple_indices.push_back(indices);
    }

    std::unordered_map<int,std::vector<int>>* get_tuple_indices_at_idx(int idx){
       return &this->predicate_tuple_indices.at(idx);
    }

    /*void set_state(DBState& s)const{
        last_state = &s;
    }*/

    DBState get_state() const {
        return last_state;
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
            const ActionSchema &action, const DBState &state,const Task &task, ThesisClass &thesis) = 0;

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
