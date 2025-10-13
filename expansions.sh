#!/bin/bash

# Base directory
BASE_DIR="error_runs/childsnack-contents"
DOMAIN="$BASE_DIR/domain.pddl"

# Memory limit in kilobytes (25 GB = 25 * 1024 * 1024 KB)
MEM_LIMIT=$((25 * 1024 * 1024))

# Array to store mismatched files
declare -a mismatched_files=()

# Function to check total system memory usage
check_memory() {
    # Get total and available memory (in kB)
    local total available used
    total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
    used=$((total - available))

    if [ "$used" -gt "$MEM_LIMIT" ]; then
        echo "🚨 Memory usage exceeded 25 GB! ($((used / 1024 / 1024)) GB used)"
        echo "Killing script to prevent overload."
        exit 1
    fi
}

# Main loop
for X in "$BASE_DIR"/*/; do
    [ -d "$X" ] || continue

    for Y in "$X"*; do
        [ -f "$Y" ] || continue

        # Check memory before each file
        check_memory

        echo "------------------------------------------"
        echo "Processing file: $Y"
        echo "------------------------------------------"

        # Run command with --th
        OUTPUT_TH=$(./powerlifted.py -d "$DOMAIN" -i "$Y" -g yannakakis -s alt-bfws1 -e ff --th 2>&1)
        EXP_TH=$(echo "$OUTPUT_TH" | grep -E "^Expanded[[:space:]]+[0-9]+" | awk '{print $2}')

        check_memory

        # Run command without --th
        OUTPUT_NO_TH=$(./powerlifted.py -d "$DOMAIN" -i "$Y" -g yannakakis -s alt-bfws1 -e ff 2>&1)
        EXP_NO_TH=$(echo "$OUTPUT_NO_TH" | grep -E "^Expanded[[:space:]]+[0-9]+" | awk '{print $2}')

        check_memory

        echo "Expanded with --th: $EXP_TH"
        echo "Expanded without --th: $EXP_NO_TH"

        # Compare results
        if [ "$EXP_TH" != "$EXP_NO_TH" ]; then
            echo "⚠️ WARNING: Expanded counts differ for $Y"
            mismatched_files+=("$Y")
        fi

        echo
    done
done

# Final statistics
echo "=========================================="
if [ ${#mismatched_files[@]} -eq 0 ]; then
    echo "✅ All files matched."
else
    echo "⚠️ The following files had mismatched Expanded counts:"
    for file in "${mismatched_files[@]}"; do
        echo " - $file"
    done
fi
echo "=========================================="
