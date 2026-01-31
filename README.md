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
./new_problem.sh <ProblemName> [NumberOfTests] [Description] [--no-edit]
```

**Arguments:**
*   `ProblemName`: Name of the directory and main cpp file.
*   `NumberOfTests`: (Optional) How many test pairs to create. Default: 1.
*   `Description`: (Optional) Problem description to include as a comment in the cpp file.
*   `--no-edit`: (Optional) Flag to skip opening the editor for the created tests.

**Examples:**
```bash
# Basic usage with 3 tests
./new_problem.sh F 3

# With description
./new_problem.sh G "Find the shortest path in a DAG."

# With description and no editor prompt
./new_problem.sh H 2 "Calculate Fibonacci." --no-edit
```

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
1.  Compile the code if necessary.
2.  Run the executable against `tests/*.in`.
3.  **Enforce a 2-second time limit** (Reports TLE).
4.  Check for **Runtime Errors** (Reports RTE).
5.  Compare output against `.out` file.
6.  If failed, display the **first 5 lines of mismatch**.

### 5. Utilities

#### Adding Extra Tests
To add a new test case pair to an existing problem without verifying the whole setup:
```bash
./add_test.sh <ProblemName>
```
It finds the next available index and opens your editor.

#### Stress Testing
Use `stress.sh` to compare your optimized solution against a brute-force solution using a random input generator.

```bash
./stress.sh <SolutionExe> <BruteForceExe> <GeneratorScript> [Iterations]
```

**Example:**
```bash
./stress.sh ./A ./A_brute ./gen.py 1000
```
This runs until the outputs differ or the iteration count is reached.

## Configuration

### Compilation Flags
The default compiler flags are set in `template/Makefile`. By default, they are:
```makefile
CXXFLAGS = -std=c++17 -Wall -Wextra -O2
```

### Templates
You can modify `template/template.cpp` to change the starting code for all new problems.
