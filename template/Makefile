CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2
TARGET = PROBLEM_NAME

all: $(TARGET)

$(TARGET): $(TARGET).cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(TARGET).cpp

run: $(TARGET)
	./$(TARGET)

test: $(TARGET)
	@for input in tests/*.in; do \
		echo "Running test $$input..."; \
		./$(TARGET) < $$input > tests/$$(basename $$input .in).myout; \
		if [ -f tests/$$(basename $$input .in).out ]; then \
			diff -w tests/$$(basename $$input .in).myout tests/$$(basename $$input .in).out && echo "Pass" || echo "Fail"; \
		else \
			cat tests/$$(basename $$input .in).myout; \
		fi \
	done

clean:
	rm -f $(TARGET) tests/*.myout
