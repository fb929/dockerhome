.DEFAULT_GOAL := run
SHELL := /bin/bash

USER := $(shell id -un)
DNS := $(shell grep '^nameserver' /etc/resolv.conf | sed 's|nameserver|--dns|' | xargs echo )
DNS_SEARCH := $(shell grep '^search' /etc/resolv.conf | sed -e 's|^search||; s| | --dns-search |g')
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
		$(DNS) \
		$(DNS_SEARCH) \
		--dns-option "timeout:3" \
		--dns-option "attempts:2" \
		--dns-option "use-vc" \
		home \
		/bin/bash

clean:
	docker system prune --all
