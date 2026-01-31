#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <problem_name> [num_tests]"
    exit 1
fi

PROBLEM_NAME=$1
NUM_TESTS=${2:-1} # Default to 1 test if not specified

if [ -d "$PROBLEM_NAME" ]; then
    echo "Directory $PROBLEM_NAME already exists!"
    exit 1
fi

mkdir -p "$PROBLEM_NAME/tests"
cp template/template.cpp "$PROBLEM_NAME/$PROBLEM_NAME.cpp"
cp template/Makefile "$PROBLEM_NAME/Makefile"

# Update Makefile with correct target name
# We use a temporary file to be portable across BSD/GNU sed
sed "s/PROBLEM_NAME/$PROBLEM_NAME/g" "$PROBLEM_NAME/Makefile" > "$PROBLEM_NAME/Makefile.tmp" && mv "$PROBLEM_NAME/Makefile.tmp" "$PROBLEM_NAME/Makefile"

# Create empty test files
for i in $(seq 1 $NUM_TESTS); do
    touch "$PROBLEM_NAME/tests/$i.in"
    touch "$PROBLEM_NAME/tests/$i.out"
    
    # Open files in default editor (fallback to nano if EDITOR not set)
    ${EDITOR:-nano} "$PROBLEM_NAME/tests/$i.in"
    ${EDITOR:-nano} "$PROBLEM_NAME/tests/$i.out"
done

echo "Created environment for $PROBLEM_NAME with $NUM_TESTS tests."
echo "cd $PROBLEM_NAME"
