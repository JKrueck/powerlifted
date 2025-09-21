#!/bin/bash

total_files=0
total_nochange=0
total_change=0
total_join_time=0

# Colors
GREEN="\e[32m"
RED="\e[31m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

# Loop over subfolders (X)
for X in error_runs/rovers-large-simple/*; do
    if [ -d "$X" ]; then
        # Loop over files (Y) inside each subfolder
        for Y in "$X"/*; do
            if [ -f "$Y" ]; then
                ((total_files++))
                echo -e "${CYAN}▶ Executing:${RESET} $Y"

                OUTPUT=$(./powerlifted.py -d "$X/domain.pddl" -i "$Y" -g yannakakis -s alt-bfws1 -e ff --th 2>&1)

                # Extract number after "Join No Change:"
                nochange_val=$(echo "$OUTPUT" | grep -oP "Join No Change:\s*\K[0-9]+" | head -n1)
                if [ -n "$nochange_val" ]; then
                    ((total_nochange+=nochange_val))
                fi

                # Extract number after "Join Change:"
                change_val=$(echo "$OUTPUT" | grep -oP "Join Change:\s*\K[0-9]+" | head -n1)
                if [ -n "$change_val" ]; then
                    ((total_change+=change_val))
                fi

                # Extract "Time used for my Join Step: <value>"
                join_time=$(echo "$OUTPUT" | grep -oP "Time used for my Join Step:\s*\K[0-9]+(\.[0-9]+)?" | head -n1)
                if [ -n "$join_time" ]; then
                    total_join_time=$(echo "$total_join_time + $join_time" | bc)
                fi

                # Normalized values
                if [ "$total_files" -gt 0 ]; then
                    avg_nochange=$(echo "scale=4; $total_nochange / $total_files" | bc)
                    avg_change=$(echo "scale=4; $total_change / $total_files" | bc)
                    avg_join_time=$(echo "scale=4; $total_join_time / $total_files" | bc)
                else
                    avg_nochange=0
                    avg_change=0
                    avg_join_time=0
                fi

                echo -e "   ${YELLOW}Progress → Files: $total_files | Join No Change: $total_nochange (avg: $avg_nochange) | Join Change: $total_change (avg: $avg_change) | Avg Join Step Time: $avg_join_time${RESET}"
                echo "------------------------------------------------------"
            fi
        done
    fi
done

echo
echo -e "${CYAN}========== FINAL SUMMARY ==========${RESET}"
echo -e "${YELLOW}Total files processed:${RESET}     $total_files"
echo -e "${GREEN}Total Join No Change:${RESET}     $total_nochange (avg per file: $(echo "scale=4; $total_nochange / $total_files" | bc))"
echo -e "${RED}Total Join Change:${RESET}        $total_change (avg per file: $(echo "scale=4; $total_change / $total_files" | bc))"
echo -e "${CYAN}Average Join Step Time:${RESET}   $(echo "scale=4; $total_join_time / $total_files" | bc)"
echo -e "${CYAN}=====================================${RESET}"
