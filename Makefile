TARGET_EXEC := main #name of the final executable file

BUILD_DIR := ./build
SRC_DIRS := ./src

CC := gcc
CFLAGS := -Wall -Wextra -Werror -pedantic -std=c2x -O0 -g3
# See CFLAGS documentation below for more information on the flags used

SRCS := $(shell find $(SRC_DIRS) -name '*.c')
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	@echo "Begin Main"
	@echo "Target:" $@
	@echo "First Dependency:" $<
	@echo "All Dependencies:" $^
	@echo $(CC) $(CFLAGS) $^ -o $@
	$(CC) $(CFLAGS) $^ -o $@

$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean all
clean:
	rm -rf $(BUILD_DIR)

################################################################################
################################ DOCUMENTATION #################################
################################################################################

# CFLAGS
#		-Wall									: enables all compiler's warning messages (ESSENTIAL)
#		-Wextra								: enables additional warning messages not covered by -Wall (ESSENTIAL)
#		-Werror								: treats all warnings as errors, which can help enforce code quality
#		-pedantic							: enables strict ISO C compliance, which can help catch non-standard code
#		-std									: specifies the C standard to use, e.g., -std=c99, -std=c11, etc.
#		-O0										: disables optimization, which can make debugging easier, use -O2 for release
# 	-g										: generates debug information for gdb while
#		-g3										: generates debug information for gdb and includes macro definitions
#		-Wfloat-equal					: useful because usually testing floating-point numbers for equality is bad.
#		-Wundef								: warn if an uninitialized identifier is evaluated in an #if directive.
#		-Wshadow							: warn whenever a local variable shadows another local variable, parameter or global variable or whenever a built-in function is shadowed.
#		-Wpointer-arith				: warn if anything depends upon the size of a function or of void.
#		-Wcast-align					: warn whenever a pointer is cast such that the required alignment of the target is increased. For example, warn if a char * is cast to an int * on machines where integers can only be accessed at two- or four-byte boundaries.
#		-Wstrict-prototypes		: warn if a function is declared or defined without specifying the argument types.
#		-Wstrict-overflow=5		: warns about cases where the compiler optimizes based on the assumption that signed overflow does not occur. (The value 5 may be too strict, see the manual page.)
#		-Wwrite-strings				: give string constants the type const char[length] so that copying the address of one into a non-const char * pointer will get a warning.
#		-Waggregate-return		: warn if any functions that return structures or unions are defined or called.
#		-Wcast-qual						: warn whenever a pointer is cast to remove a type qualifier from the target type*.
#		-Wswitch-default			: warn whenever a switch statement does not have a default case*.
#		-Wswitch-enum					: warn whenever a switch statement has an index of enumerated type and lacks a case for one or more of the named codes of that enumeration*.
#		-Wconversion					: warn for implicit conversions that may alter a value*.
#		-Wunreachable-code		: warn if the compiler detects that code will never be executed*.
#		-Wformat=2						: Extra format checks on printf/scanf functions.
#		 Those marked * sometimes give too many spurious warnings, so I use them on as-needed basis.