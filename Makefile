USER := g.efimov
MNT_DIR := $(shell pwd)/mnt
export DOCKER_BUILDKIT:=1

build:
	install -d $(MNT_DIR)
	docker image build \
		--build-arg USER=$(USER) \
		--file Dockerfile \
		--tag home \
		.
run:
	docker run \
		--interactive \
		--tty \
		--volume $(MNT_DIR):/mnt \
		--rm \
		--privileged \
		--cap-add=ALL \
		home \
		/bin/bash
