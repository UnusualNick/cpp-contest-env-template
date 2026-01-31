#!/bin/bash

# stress.sh - Stress testing script
# Usage: ./stress.sh <Solution_Exe> <Brute_Exe> <Generator> [Num_Iter]

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <solution_exe> <brute_exe> <generator_exe_or_script> [num_iterations]"
    echo "Example: ./stress.sh ./A ./A_brute ./gen.py"
    exit 1
fi

SOL=$1
BRUTE=$2
GEN=$3
NUM_ITER=${4:-1000}

# Compile check (optional logic could go here)

for ((i=1; i<=NUM_ITER; i++)); do
    echo -ne "Test $i... "
    
    # Run Generator
    # Check if generator is a python script or executable
    if [[ "$GEN" == *.py ]]; then
        python3 "$GEN" > input.tmp
    else
        "$GEN" > input.tmp
    fi

    # Run Solution
    "$SOL" < input.tmp > out1.tmp
    
    # Run Brute Force
    "$BRUTE" < input.tmp > out2.tmp
    
    # Compare
    if diff -w out1.tmp out2.tmp > /dev/null; then
        echo "OK"
    else
        echo "FAILED"
        echo "Input:"
        cat input.tmp
        echo ""
        echo "Your Output:"
        cat out1.tmp
        echo ""
        echo "Brute Output:"
        cat out2.tmp
        echo ""
        break
    fi
done

rm -f input.tmp out1.tmp out2.tmp
