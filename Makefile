CC := gcc

LASER_DEFINES=-DLASER_NF_SYMBOLS

CFLAGS := -Wall -Wextra -pedantic $(LASER_DEFINES)
CFLAGS_DEBUG := $(CFLAGS) -g -DDEBUG -fsanitize=address
CFLAGS_RELEASE := $(CFLAGS) -O2 -DNDEBUG

LDFLAGS := 
LDFLAGS_DEBUG := $(LDFLAGS) -fsanitize=address

SRC_DIR := src
BIN_DIR := bin
OBJ_DIR := $(BIN_DIR)/obj

SRCS := $(shell find $(SRC_DIR) -name "*.c")
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

TARGET := $(BIN_DIR)/lsr

.PHONY: all debug release clean format test install uninstall

all: debug

debug: $(TARGET)

release: $(TARGET)

$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $^ -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN_DIR) $(OBJ_DIR):
	-mkdir -p $@
	-mkdir -p $(shell dirname $(OBJS))

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

format:
	clang-format -i $(SRC_DIR)/*.c $(SRC_DIR)/include/*.h

install: release
	install -m 755 $(TARGET) /usr/local/bin

uninstall:
	rm -f /usr/local/bin/$(notdir $(TARGET))
