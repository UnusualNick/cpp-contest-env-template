# Complexity Analysis Course

This repository contains a structured environment for solving and analyzing algorithmic problems. It provides a consistent workflow for creating new problem environments, writing solutions in C++, and verifying correctness through automated testing.

## Prerequisites

- **GCC/G++**: A C++ compiler supporting C++17.
- **Make**: For build automation.
- **Bash**: For running the setup scripts.

## Project Structure

The repository is organized by problem names. Each problem directory contains:

- `Source Code`: The C++ solution file (e.g., `A/A.cpp`).
- `Makefile`: Problem-specific build and test rules.
- `tests/`: A directory containing input (`.in`) and expected output (`.out`) files.

Additionally, a `template/` directory holds the base files used for generating new problems.

## Usage

### 1. Creating a New Problem

Use the provided `new_problem.sh` script to bootstrap a new problem directory. This will create the folder structure, copy the template, and prompt you to create initial test cases.

```bash
./new_problem.sh <ProblemName> [NumberOfTests]
```

**Example:**
```bash
./new_problem.sh F 3
```
This commands creates a directory `F`, generates `F.cpp` and `Makefile`, and opens editors for 3 pairs of test files (`.in` / `.out`).

### 2. Solving the Problem

Navigate to the problem directory:
```bash
cd F
```
Edit the solution file `F.cpp` with your implementation.

### 3. Compilation

To compile the solution:
```bash
make
```
This generates an executable named after the problem (e.g., `F`).

### 4. Running Tests

To run the solution against the provided test cases:
```bash
make test
```

This command will:
1. Compile the code if necessary.
2. Run the executable for each `.in` file in the `tests/` directory.
3. Save the output to a `.myout` file.
4. Compare it against the corresponding `.out` expected output file (if it exists).
5. Report "Pass" or "Fail".

## Configuration

### Compilation Flags
The default compiler flags are set in `template/Makefile`. By default, they are:
```makefile
CXXFLAGS = -std=c++17 -Wall -Wextra -O2
```

### Templates
You can modify `template/template.cpp` to change the starting code for all new problems.
