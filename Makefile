GBDK    := /usr/share/gbdk-2020
LCC     := lcc

CFLAGS  := -c -msm83:gb -I$(GBDK)/include
LFLAGS  := -msm83:gb -Wl-m -Wl-j

TARGET  := build/swordy.gbc
SRCS    := $(wildcard src/*.c)
OBJS    := $(patsubst src/%.c, build/%.o, $(SRCS))

.PHONY: all clean

all: build $(TARGET)

build:
	mkdir -p build

build/%.o: src/%.c
	$(LCC) $(CFLAGS) -o $@ $<

$(TARGET): $(OBJS)
	$(LCC) $(LFLAGS) -o $@ $^

clean:
	rm -rf build
