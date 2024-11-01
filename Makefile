CC ?= gcc
C_FLAGS := -std=gnu11 $\
					 -O2 -march=native -pipe $\
					 -Wall -Wextra -Wpedantic -Wno-nonnull -Wno-unused-parameter $\
					 -Iinclude

INSTALL_DIRECTORY := /usr/local/bin

PROCESSED_HEADER_FILES := $(subst .h,$\
														$(if $(findstring clang,${CC}),$\
															.h.pch,$\
															.h.gch),$\
														$(shell find include -name '*.h'))
OBJECT_FILES := $(patsubst src/%.c,$\
									build/%.o,$\
									$(shell find src -name '*.c'))

define REMOVE_LIST
	$(foreach ITEM,$\
		$(1),$\
		$(if $(wildcard ${ITEM}),$\
			$(shell rm ${ITEM})))

endef

all: ctatus

build/%.o: src/%.c
	${CC} -c $< ${C_FLAGS} -o $@

%.gch: %
	${CC} -c $< ${C_FLAGS}

%.pch: %
	${CC} -c $< ${C_FLAGS}

ctatus: ${PROCESSED_HEADER_FILES} ${OBJECT_FILES}
	${CC} ${OBJECT_FILES} -o ctatus

install: ctatus ${INSTALL_DIRECTORY} uninstall
	cp ctatus ${INSTALL_DIRECTORY}

uninstall:
ifneq (,$(wildcard ${INSTALL_DIRECTORY}/ctatus))
	rm ${INSTALL_DIRECTORY}/ctatus
endif

clean:
	$(call REMOVE_LIST,$\
		${OBJECT_FILES})
	$(call REMOVE_LIST,$\
		${PROCESSED_HEADER_FILES})
ifneq (,$(wildcard ctatus))
	rm ctatus
endif

.PHONY: all clean install uninstall
