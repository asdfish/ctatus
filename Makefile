CC ?= gcc
C_FLAGS := -std=gnu11 $\
					 -O2 -march=native -pipe $\
					 -Wall -Wextra -Wpedantic -Wno-nonnull -Wno-unused-parameter $\
					 -Iinclude

INSTALL_DIRECTORY := /usr/local/bin

OBJECT_FILES := build/main.o build/modules.o

define REMOVE_LIST
	$(foreach ITEM,$\
		$(1),$\
		$(if $(wildcard ${ITEM}),$\
			rm ${ITEM}))

endef

all: ctatus

build/%.o :src/%.c
	${CC} -c $< ${C_FLAGS} -o $@

ctatus: ${OBJECT_FILES}
	${CC} ${OBJECT_FILES} -o ctatus

install: ctatus ${INSTALL_DIRECTORY}
	-cp -f ctatus ${INSTALL_DIRECTORY}

uninstall:
	-rm -f ${INSTALL_DIRECTORY}/ctatus

clean:
	$(call REMOVE_LIST,$\
		${OBJECT_FILES})
ifneq (,$(wildcard ctatus))
	rm ctatus
endif

.PHONY: all clean install uninstall
