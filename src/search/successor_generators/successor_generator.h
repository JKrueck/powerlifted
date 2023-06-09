#ifndef SEARCH_SUCCESSOR_GENERATOR_H
#define SEARCH_SUCCESSOR_GENERATOR_H

#include <vector>
#include <unordered_set>
#include <unordered_map>

#include "../database/table.h"
#include "../database/utils.h"
#include "../structures.h"


// A few forward declarations :-)
class ActionSchema;
class DBState;
class LiftedOperatorId;

class Task;
class Table;



class ThesisClass
{

private:
    std::vector<Table> thesis_table;
    //Storage for the hash-join matches; per action
    std::vector<std::unordered_set<int>> thesis_match;
    //Storage of the grounded action add effects
    std::vector<std::vector<GroundAtom>> diff;
    //Storage of the correspondence between tuple indices in the join tables and predicate index; per action
    std::vector<std::unordered_map<int,std::vector<int>>> predicate_tuple_indices;
    bool thesis_enable;
public:
    ThesisClass(bool enable) : thesis_enable(enable)
    {}

    ThesisClass() = default;
        
        
   
    //~ThesisClass();

    std::vector<Table>* get_tables(){
        return &this->thesis_table;
    }

    std::vector<Table> get_tables_copy(){
        return this->thesis_table;
    }

    Table* get_table_at_idx(int idx){
        return &this->thesis_table.at(idx);
    }

    Table get_table_copy_at_idx(int idx){
        return this->thesis_table.at(idx);
    }

    //don´t now if the move is good here
    void insert_table(Table tab){
        this->thesis_table.push_back(std::move(tab));
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

    void insert_diff(std::vector<GroundAtom> set_diff){
        this->diff.push_back(set_diff);
    }

    std::vector<GroundAtom>* get_diff_at_idx(int idx){
        return &this->diff.at(idx);
    }

    void insert_tuple_indices(std::unordered_map<int,std::vector<int>> indices){
        this->predicate_tuple_indices.push_back(indices);
    }

    std::unordered_map<int,std::vector<int>>* get_tuple_indices_at_idx(int idx){
       return &this->predicate_tuple_indices.at(idx);
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
            const ActionSchema &action, const DBState &state,const Task &task, 
            Table &thesis_table, std::unordered_set<int> &thesis_matching, 
            std::unordered_map<int,std::vector<int>> &thesis_indices) = 0;

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
