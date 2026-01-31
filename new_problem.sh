#!/bin/bash

# Parse optional flags
OPEN_EDITOR=true
ARGS=()

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --no-edit)
            OPEN_EDITOR=false
            shift
            ;;
        *)
            ARGS+=("$1")
            shift
            ;;
    esac
done

# Restore positional arguments
set -- "${ARGS[@]}"

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <problem_name> [num_tests] [description...] [--no-edit]"
    exit 1
fi

PROBLEM_NAME=$1
shift

NUM_TESTS=1
DESCRIPTION=""

# Check if the next argument is a positive integer (number of tests)
if [[ "$1" =~ ^[0-9]+$ ]]; then
    NUM_TESTS=$1
    shift
fi

# All remaining arguments are treated as the description
if [ "$#" -gt 0 ]; then
    DESCRIPTION="$*"
fi

if [ -d "$PROBLEM_NAME" ]; then
    echo "Directory $PROBLEM_NAME already exists!"
    exit 1
fi

mkdir -p "$PROBLEM_NAME/tests"
cp template/template.cpp "$PROBLEM_NAME/$PROBLEM_NAME.cpp"

# Add description as header comment if provided
if [ -n "$DESCRIPTION" ]; then
    TEMP_CPP=$(mktemp)
    echo "/*" > "$TEMP_CPP"
    echo " * Problem: $PROBLEM_NAME" >> "$TEMP_CPP"
    echo " * Description:" >> "$TEMP_CPP"
    echo "$DESCRIPTION" | fold -w 75 -s | sed 's/^/ * /' >> "$TEMP_CPP"
    echo " */" >> "$TEMP_CPP"
    echo "" >> "$TEMP_CPP"
    cat "$PROBLEM_NAME/$PROBLEM_NAME.cpp" >> "$TEMP_CPP"
    mv "$TEMP_CPP" "$PROBLEM_NAME/$PROBLEM_NAME.cpp"
fi

cp template/Makefile "$PROBLEM_NAME/Makefile"

# Update Makefile with correct target name
sed "s/PROBLEM_NAME/$PROBLEM_NAME/g" "$PROBLEM_NAME/Makefile" > "$PROBLEM_NAME/Makefile.tmp" && mv "$PROBLEM_NAME/Makefile.tmp" "$PROBLEM_NAME/Makefile"

# Create empty test files
for i in $(seq 1 $NUM_TESTS); do
    touch "$PROBLEM_NAME/tests/$i.in"
    touch "$PROBLEM_NAME/tests/$i.out"
    
    # Open files in default editor (fallback to nano if EDITOR not set)
    if [ "$OPEN_EDITOR" = true ]; then
        ${EDITOR:-nano} "$PROBLEM_NAME/tests/$i.in"
        ${EDITOR:-nano} "$PROBLEM_NAME/tests/$i.out"
    fi
done

echo "Created environment for $PROBLEM_NAME with $NUM_TESTS tests."
echo "cd $PROBLEM_NAME"
