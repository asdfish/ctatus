STANDARD := -std=gnu11
LINK_FLAGS := 
INCLUDE_FLAGS := 
SOURCE_FILES := src/main.c src/modules.c
HEADER_FILES := src/definitions.h src/modules.h
DEBUG_FLAGS := -Wall -Wextra -Wpedantic -Wno-nonnull -Wno-unused-parameter
OPTIMIZATION_FLAGS := -O2 -march=native
CC ?= gcc
INSTALL_DIRECTORY := /usr/local/bin

OBJECT_FILES := 

define COMPILE_FILE
	${CC} -c ${STANDARD} $(1) ${INCLUDE_FLAGS} ${DEBUG_FLAGS} ${OPTIMIZATION_FLAGS} -o build/$(notdir $(1)).o 
	$(eval OBJECT_FILES+=build/$(notdir $(1)).o)

endef

all:  compile

compile: build_prep ${SOURCE_FILES} ${HEADER_FILES}
	$(foreach SOURCE_FILE,$\
	  ${SOURCE_FILES},$\
	  $(call COMPILE_FILE,${SOURCE_FILE})$\
	)
	${CC} ${OBJECT_FILES} ${LINK_FLAGS} -o ctatus

build_prep:
ifeq (, $(wildcard build))
	mkdir build
endif

dependencies_prep:
ifeq (, $(wildcard deps))
	mkdir deps
endif



install: ${INSTALL_DIRECTORY}
ifeq (, $(wildcard ctatus))
	make
endif
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
