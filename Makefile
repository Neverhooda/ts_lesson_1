IMAGE     ?= tslib_tool:1.0
IMAGE_WIN ?= tslib_tool_win
PROFILE   ?= default
SSH_PORT  ?= 5000
PROJECT   := /home/conan/project

UBUNTU_VERSION ?= 20.04
CONAN_VERSION  := $(patsubst conan==%,%,$(filter conan==%,$(file < requirements.txt)))

.PHONY: help versions deps package image build shell image-win run-win clean

help:
	@echo "make versions   - print pinned tool versions"
	@echo "make deps       - install pinned python tools on the host"
	@echo "make package    - conan create on the host (PROFILE=$(PROFILE))"
	@echo "make image      - build docker image $(IMAGE)"
	@echo "make build      - conan create inside $(IMAGE)"
	@echo "make shell      - interactive shell inside $(IMAGE)"
	@echo "make image-win  - build docker image $(IMAGE_WIN) for Visual Studio"
	@echo "make run-win    - run $(IMAGE_WIN) with ssh on port $(SSH_PORT)"
	@echo "make clean      - remove build artifacts"

versions:
	@echo "conan  $(CONAN_VERSION)"
	@echo "ubuntu $(UBUNTU_VERSION)"

deps:
	pip3 install -r requirements.txt

package:
	conan create . -pr $(PROFILE) --build missing

image:
	docker build --build-arg CONAN_VERSION=$(CONAN_VERSION) --tag $(IMAGE) .

build: image
	docker run --rm -v $(CURDIR):$(PROJECT) $(IMAGE) /bin/bash build.sh

shell: image
	docker run -it --rm -v $(CURDIR):$(PROJECT) $(IMAGE) /bin/bash

image-win:
	docker build --build-arg UBUNTU_VERSION=$(UBUNTU_VERSION) -t $(IMAGE_WIN) -f Dockerfile_win .

run-win: image-win
	docker run -it -p $(SSH_PORT):22 $(IMAGE_WIN) /bin/bash

clean:
	rm -rf test_package/build build .conan
