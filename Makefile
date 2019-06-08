CMAKE_INSTALL_PREFIX ?= $(HOME)/.cmake_install
PROJECT_BINARY_DIR := $(abspath dist)
PROJECT_SOURCE_DIR := $(abspath .)

.PHONY: all reset_submodules clean install build

all:
	@echo nothing special

reset_submodules:
	git submodule update --init --recursive

clean:
	rm -rf build dist

install: build
	cd $(PROJECT_BINARY_DIR) && \
		make install
build: 
	mkdir -p $(PROJECT_BINARY_DIR) && cd $(PROJECT_BINARY_DIR) && \
		cmake $(PROJECT_SOURCE_DIR) \
			-DCMAKE_INSTALL_PREFIX=$(CMAKE_INSTALL_PREFIX) && \
		make -j4
