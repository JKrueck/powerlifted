#ifndef SEARCH_PROJECT_H
#define SEARCH_PROJECT_H

#include "../successor_generators/successor_generator.h"

#include <unordered_set>
#include <iostream>
#include <climits>

class Table;

void project(Table &t, const std::unordered_set<int> &over, ThesisSave &join_save, int key_index);

#endif //SEARCH_PROJECT_H
