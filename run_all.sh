#!/bin/bash

# Script to run all solve.sh scripts in the problem directories

tasks=($(ls -d */ | grep -v "template/" | sed 's/\///'))

for task in "${tasks[@]}"; do
    if [ -d "$task" ] && [ -f "$task/solve.sh" ]; then
        echo "========================================"
        echo "Running solution agent for Task $task"
        echo "========================================"
        
        # Enter directory
        pushd "$task" > /dev/null
        
        # Make sure it's executable
        chmod +x solve.sh
        
        # Run the script
        ./solve.sh
        
        # Return to previous directory
        popd > /dev/null
        
        echo "Finished Task $task"
        echo ""
    else
        # Silently skip if no solve.sh found, as it might just be a non-problem folder
        :
    fi
done

echo "All tasks completed."
