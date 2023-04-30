.DEFAULT_GOAL := run
SHELL := /bin/bash

USER := $(shell id -un)
DNS_SEARCH := "local"
MNT_DIR := $(shell pwd)/mnt
export DOCKER_BUILDKIT:=1

build:
	install -d $(MNT_DIR)
	docker image build \
		--build-arg USER=$(USER) \
		--file Dockerfile \
		--tag home \
		.
run: build
	docker run \
		--interactive \
		--tty \
		--volume $(MNT_DIR):/mnt \
		--rm \
		--privileged \
		--cap-add=ALL \
		--dns-search $(DNS_SEARCH) \
		home \
		/bin/bash

clean:
	docker system prune --all
