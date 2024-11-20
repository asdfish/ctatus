CC ?= gcc
CFLAGS ?= -O2 -march=native -pipe
COMMONFLAGS := -std=gnu11 $\
							 -Wall -Wextra -Wpedantic -Wno-nonnull -Wno-unused-parameter $\
							 -Iinclude

INSTALL_DIRECTORY := /usr/local/bin

# uncomment/comment to enable/disable
# PROCESS_HEADER_FILES := yes
PROCESSED_HEADER_FILES := $(if ${PROCESS_HEADER_FILES},$\
														$(subst .h,$\
															$(if $(findstring clang,${CC}),$\
																.h.pch,$\
																.h.gch),$\
															$(shell find include -name '*.h')))
OBJECT_FILES := $(patsubst src/%.c,$\
									build/%.o,$\
									$(shell find src -name '*.c'))

CTATUS_REQUIREMENTS := ${PROCESSED_HEADER_FILES} ${OBJECT_FILES}

define COMPILE
${CC} -c $(1) ${CFLAGS} ${COMMONFLAGS} -o $(2)

endef
define REMOVE
$(if $(wildcard $(1)),$\
	rm $(1))

endef
define REMOVE_LIST
$(foreach ITEM,$\
	$(1),$\
	$(call REMOVE,${ITEM}))

endef

all: ctatus

build/%.o: src/%.c
	$(call COMPILE,$<,$@)

%.gch: %
	$(call COMPILE,$<,$@)

%.pch: %
	$(call COMPILE,$<,$@)

ctatus: ${CTATUS_REQUIREMENTS}
	${CC} ${OBJECT_FILES} ${CFLAGS} ${COMMONFLAGS} -o ctatus

install: ctatus ${INSTALL_DIRECTORY} uninstall
	cp ctatus ${INSTALL_DIRECTORY}

uninstall:
	$(call REMOVE,${INSTALL_DIRECTORY}/ctatus)

clean:
	$(call REMOVE_LIST,${CTATUS_REQUIREMENTS})
	$(call REMOVE,ctatus)

.PHONY: all clean install uninstall
