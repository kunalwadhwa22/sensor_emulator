SHELL=/bin/bash

TARGET_EXEC ?= a.out

BUILD_DIR ?= ./build

SRCS := ./*.c \
				./src/file_stream/*.c

OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

INC_DIRS := include/ \
						include/file_stream/

INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CPPFLAGS ?= $(INC_FLAGS) -MMD -MP


run: all
	$(BUILD_DIR)/$(TARGET_EXEC)

all: $(BUILD_DIR)/$(TARGET_EXEC)

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# assembly
$(BUILD_DIR)/%.s.o: %.s
	$(MKDIR_P) $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# c++ source
$(BUILD_DIR)/%.cpp.o: %.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@


.PHONY: clean

clean:
	$(RM) -r $(BUILD_DIR)

-include $(DEPS)

MKDIR_P ?= mkdir -p

.PHONY: run


# CXX      := -c++
# CXXFLAGS := -pedantic-errors -Wall -Wextra -Werror
# LDFLAGS  := -L/usr/lib -lstdc++ -lm
# BUILD    := ./build
# OBJ_DIR  := $(BUILD)/objects
# APP_DIR  := $(BUILD)/apps
# TARGET   := program
# INCLUDE  := -Iinclude/
# SRC      :=                      \
#    $(wildcard src/module1/*.cpp) \
#    $(wildcard src/module2/*.cpp) \
#    $(wildcard src/module3/*.cpp) \
#    $(wildcard src/*.cpp)         \

# OBJECTS  := $(SRC:%.cpp=$(OBJ_DIR)/%.o)

# all: build $(APP_DIR)/$(TARGET)

# $(OBJ_DIR)/%.o: %.cpp
#    @mkdir -p $(@D)
#    $(CXX) $(CXXFLAGS) $(INCLUDE) -c $< -o $@ $(LDFLAGS)

# $(APP_DIR)/$(TARGET): $(OBJECTS)
#    @mkdir -p $(@D)
#    $(CXX) $(CXXFLAGS) -o $(APP_DIR)/$(TARGET) $^ $(LDFLAGS)

# .PHONY: all build clean debug release

# build:
#    @mkdir -p $(APP_DIR)
#    @mkdir -p $(OBJ_DIR)

# debug: CXXFLAGS += -DDEBUG -g
# debug: all

# release: CXXFLAGS += -O2
# release: all

# clean:
#    -@rm -rvf $(OBJ_DIR)/*
#    -@rm -rvf $(APP_DIR)/*