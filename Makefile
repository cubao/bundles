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

DOCKER_BUILD_TAG := cubao/basic
docker_test_build:
	docker run --rm -v `pwd`:/workdir \
		-it $(DOCKER_BUILD_TAG) zsh

DOCKER_RELEASE_TAG := cubao/basic-bundles
docker_build:
	docker build \
		--tag $(DOCKER_RELEASE_TAG) .
docker_push:
	docker push $(DOCKER_RELEASE_TAG)
docker_test_release:
	docker run --rm -v `pwd`:/workdir -it $(DOCKER_RELEASE_TAG) zsh
