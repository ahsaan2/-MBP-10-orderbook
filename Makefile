CXX = g++
CXXFLAGS = -std=c++17 -O3 -march=native -Wall -Wextra
LDFLAGS =

TARGET = reconstruction_ahsaan
SRC_DIR = src
OBJ_DIR = obj
TEST_DIR = test

SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRCS))

.PHONY: all clean test

all: $(TARGET)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

test: all
	$(CXX) $(CXXFLAGS) $(TEST_DIR)/test_mbp.cpp -I src -lgtest -lpthread -o test_mbp
	./test_mbp

clean:
	rm -rf $(OBJ_DIR) $(TARGET) test_mbp