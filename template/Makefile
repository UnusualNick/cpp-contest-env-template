CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2
TARGET = PROBLEM_NAME

all: $(TARGET)

$(TARGET): $(TARGET).cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(TARGET).cpp

run: $(TARGET)
	./$(TARGET)


test: $(TARGET)
	@echo "Testing $(TARGET)..."
	@for input in tests/*.in; do \
		test_name=$$(basename $$input .in); \
		timeout 2s ./$(TARGET) < $$input > tests/$$test_name.myout; \
		exit_code=$$?; \
		if [ $$exit_code -eq 124 ]; then \
			echo "Test $$test_name: TLE (Time Limit Exceeded)"; \
		elif [ $$exit_code -ne 0 ]; then \
			echo "Test $$test_name: RTE (Runtime Error) - code $$exit_code"; \
		elif [ -f tests/$$test_name.out ]; then \
			if diff -w tests/$$test_name.myout tests/$$test_name.out > /dev/null; then \
				echo "Test $$test_name: PASS"; \
			else \
				echo "Test $$test_name: FAIL"; \
				echo "Expected:"; \
				head -n 5 tests/$$test_name.out; \
				echo "Got:"; \
				head -n 5 tests/$$test_name.myout; \
			fi; \
		else \
			echo "Test $$test_name: RUN (No output file)"; \
		fi; \
	done
		fi \
	done

clean:
	rm -f $(TARGET) tests/*.myout
