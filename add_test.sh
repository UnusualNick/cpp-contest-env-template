#!/bin/bash

# usage: ./add_test.sh <PROBLEM_NAME> [--no-edit]
# To provide input via stdin: echo "input" | ./add_test.sh <PROBLEM_NAME>

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <problem_name> [--no-edit]"
    exit 1
fi

PROBLEM_NAME=$1
shift

# Check for optional --no-edit flag
NO_EDIT=false
if [ "$1" == "--no-edit" ]; then
    NO_EDIT=true
    shift
fi

if [ ! -d "$PROBLEM_NAME/tests" ]; then
    echo "Error: Directory '$PROBLEM_NAME/tests' does not exist."
    exit 1
fi

# Find the next available test index
i=1
while [ -f "$PROBLEM_NAME/tests/$i.in" ]; do
    ((i++))
done

# Create the files
touch "$PROBLEM_NAME/tests/$i.in"
touch "$PROBLEM_NAME/tests/$i.out"

# Check if input is being piped (stdin is not a TTY)
if [ ! -t 0 ]; then
    # Read from stdin into the input file
    cat > "$PROBLEM_NAME/tests/$i.in"
    echo "Read test case input from stdin into $PROBLEM_NAME/tests/$i.in"
    
    # If input is piped, assume non-interactive mode and skip editor
    NO_EDIT=true
else
    echo "Created empty test case $i in $PROBLEM_NAME/tests/"
fi

if [ "$NO_EDIT" = false ]; then
    # Open both input and output files in the editor
    ${EDITOR:-nano} "$PROBLEM_NAME/tests/$i.in"
    ${EDITOR:-nano} "$PROBLEM_NAME/tests/$i.out"
else
    echo "Skipping editor."
fi
