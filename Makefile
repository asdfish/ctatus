STANDARD := -std=gnu11
LINK_FLAGS := 
DEBUG_FLAGS := -Wall -Wextra -Wpedantic -Wno-nonnull -Wno-unused-parameter
OPTIMIZATION_FLAGS := -O2 -march=native
CC ?= gcc
INSTALL_DIRECTORY := /usr/local/bin

OBJECT_FILES := build/main.c.o build/modules.c.o

define COMPILE_FILE
	${CC} -c ${STANDARD} $(1) ${INCLUDE_FLAGS} ${DEBUG_FLAGS} ${OPTIMIZATION_FLAGS} -o build/$(notdir $(1)).o 

endef

all: ctatus

build:
	mkdir build

build/main.c.o: config.h src/definitions.h src/modules.h src/main.c
	$(call COMPILE_FILE,src/main.c)

build/modules.c.o: config.h src/modules.h src/modules.c
	$(call COMPILE_FILE,src/modules.c)

ctatus: build ${OBJECT_FILES}
	${CC} ${OBJECT_FILES} ${LINK_FLAGS} -o ctatus

install: ctatus ${INSTALL_DIRECTORY}
	cp -f ctatus ${INSTALL_DIRECTORY}

uninstall:
ifneq (, $(wildcard ${INSTALL_DIRECTORY}/ctatus))
	rm -f ${INSTALL_DIRECTORY}/ctatus
endif

clean:
ifneq (, $(wildcard ctatus))
	rm -f ctatus
endif
ifneq (, $(wildcard build))
	rm -rf build
endif
ifneq (, $(wildcard deps))
	rm -rf deps
endif
ifneq (, $(wildcard *.orig))
	rm *.orig
endif
ifneq (, $(wildcard *.rej))
	rm *.rej
endif
ifneq (, $(wildcard src/*.orig))
	rm src/*.orig
endif
ifneq (, $(wildcard src/*.rej))
	rm src/*.rej
endif
