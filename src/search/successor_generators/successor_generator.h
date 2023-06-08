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
    Table thesis_table;
    std::unordered_set<int> thesis_match;
    std::vector<GroundAtom> diff;
    std::unordered_map<int,std::vector<int>> predicate_tuple_indices;
    bool thesis_enable;
public:
    ThesisClass(Table match_table, std::unordered_set<int> matches, bool enable) :
        thesis_table(std::move(match_table)), thesis_match(matches), thesis_enable(enable)
    {}

    ThesisClass() = default;
        
        
   
    //~ThesisClass();

    Table* get_table(){
        return &this->thesis_table;
    }

    Table get_table_copy(){
        return this->thesis_table;
    }

    std::unordered_set<int> get_matches(){
        return this->thesis_match;
    }

    const bool is_enabled(){
        return thesis_enable;
    }

    void set_diff(std::vector<GroundAtom> set_diff){
        this->diff = set_diff;
    }

    std::vector<GroundAtom> get_diff(){
        return this->diff;
    }

    void set_tuple_indices(std::unordered_map<int,std::vector<int>> indices){
        this->predicate_tuple_indices = indices;
    }

    std::unordered_map<int,std::vector<int>> get_tuple_indices(){
       return this->predicate_tuple_indices;
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
                                ThesisClass &thes_class) = 0;

    void add_to_added_atoms(int i, const std::vector<int> & atom) {
        added_atoms.emplace_back(i, atom);
    }

    virtual const std::vector<std::pair<int, std::vector<int>>> &get_added_atoms() const {
        return added_atoms;
    }

};

#endif //SEARCH_SUCCESSOR_GENERATOR_H
