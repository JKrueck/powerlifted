#!/bin/bash

total_files=0
hiii_occurrences=0
nochange_occurrences=0

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

                # Count occurrences of "HIII"
                hiii_count=$(echo "$OUTPUT" | grep -o "HIII" | wc -l)
                ((hiii_occurrences+=hiii_count))

                # Count occurrences of "No changed table size"
                nochange_count=$(echo "$OUTPUT" | grep -o "No changed table size" | wc -l)
                ((nochange_occurrences+=nochange_count))

                # Normalized values (avoid division by zero)
                if [ "$total_files" -gt 0 ]; then
                    avg_hiii=$(echo "scale=4; $hiii_occurrences / $total_files" | bc)
                    avg_nochange=$(echo "scale=4; $nochange_occurrences / $total_files" | bc)
                else
                    avg_hiii=0
                    avg_nochange=0
                fi

                echo -e "   ${YELLOW}Progress → Files: $total_files | HIII: $hiii_occurrences (avg: $avg_hiii) | No changed table size: $nochange_occurrences (avg: $avg_nochange)${RESET}"
                echo "------------------------------------------------------"
            fi
        done
    fi
done

echo
echo -e "${CYAN}========== FINAL SUMMARY ==========${RESET}"
echo -e "${YELLOW}Total files processed:${RESET}        $total_files"
echo -e "${GREEN}Total HIII occurrences:${RESET}       $hiii_occurrences (avg per file: $(echo "scale=4; $hiii_occurrences / $total_files" | bc))"
echo -e "${RED}Total 'No changed table size':${RESET} $nochange_occurrences (avg per file: $(echo "scale=4; $nochange_occurrences / $total_files" | bc))"
echo -e "${CYAN}=====================================${RESET}"
