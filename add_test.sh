#!/bin/bash

# usage: ./add_test.sh <PROBLEM_NAME>

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <problem_name>"
    exit 1
fi

PROBLEM_NAME=$1

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

echo "Created test case $i in $PROBLEM_NAME/tests/"

# Open in editor
${EDITOR:-nano} "$PROBLEM_NAME/tests/$i.in"
${EDITOR:-nano} "$PROBLEM_NAME/tests/$i.out"
