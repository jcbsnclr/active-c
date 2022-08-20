CC?=gcc

CSRC=$(wildcard source/*.c)
COBJ=$(patsubst source/%.c, build/%.c.o, $(CSRC))

CFLAGS+=-Og -g -Wall -Werror -Wextra -Iinclude/ -c -MMD 
LFLAGS+=

BIN=build/active-c

build/%.c.o: source/%.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $< -o $@

$(BIN): $(COBJ)
	$(CC) $(COBJ) $(LFLAGS) -o $@

.PHONY: all run dbg clean

all: $(BIN)

run: $(BIN)
	./$(BIN)

dbg: $(BIN)
	gdb $(BIN)

clean:
	rm -f build/

-include build/*.c.d