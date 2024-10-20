CC ?= gcc
C_FLAGS := -std=gnu11 $\
					 -O2 -march=native -pipe $\
					 -Wall -Wextra -Wpedantic -Wno-nonnull -Wno-unused-parameter $\
					 -Iinclude
LD_FLAGS :=

DIRECTORIES := build

INSTALL_DIRECTORY := /usr/local/bin

OBJECT_FILES := build/main.o build/modules.o

all: ctatus

${DIRECTORIES}:
	-mkdir ${DIRECTORIES}

${OBJECT_FILES}: build/%.o :src/%.c
	${CC} -c $< ${C_FLAGS} -o $@

ctatus: build ${OBJECT_FILES}
	${CC} ${OBJECT_FILES} ${LD_FLAGS} -o ctatus

install: ctatus ${INSTALL_DIRECTORY}
	-cp -f ctatus ${INSTALL_DIRECTORY}

uninstall:
	-rm -f ${INSTALL_DIRECTORY}/ctatus

clean:
	-rm -f ctatus
	-rm -rf build
	-rm *.orig
	-rm *.rej
	-rm src/*.orig
	-rm src/*.rej

.PHONY: all clean install uninstall
