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
	$(foreach DIRECTORY,$\
		${DIRECTORIES},$\
		$(if $(wildcard ${DIRECTORY}),,$\
			$(shell mkdir ${DIRECTORY})$\
		)$\
	)

${OBJECT_FILES}: build/%.o :src/%.c
	${CC} -c $< ${C_FLAGS} -o $@

ctatus: build ${OBJECT_FILES}
	${CC} ${OBJECT_FILES} ${LD_FLAGS} -o ctatus

install: ctatus ${INSTALL_DIRECTORY}
	cp -f ctatus ${INSTALL_DIRECTORY}

uninstall:
ifneq (, $(wildcard ${INSTALL_DIRECTORY}/ctatus))
	rm -f ${INSTALL_DIRECTORY}/ctatus
endif

clean:
	-rm -f ctatus
	-rm -rf build
	-rm *.orig
	-rm *.rej
	-rm src/*.orig
	-rm src/*.rej

.PHONY: clean
