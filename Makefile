#
# MIT License
#
# (C) Copyright 2022-2023 Hewlett Packard Enterprise Development LP
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
NAME ?= ${NAME}
DOCKER_BUILDKIT ?= ${DOCKER_BUILDKIT}
SLES_VERSION := ${SLES_VERSION}
VERSION ?= ${VERSION}
ifeq ($(TIMESTAMP),)
TIMESTAMP := $(shell date '+%Y%m%d%H%M%S')
endif

all: image

image:
	docker buildx create --use
	docker buildx build --platform=linux/amd64,linux/arm64 --secret id=SLES_REGISTRATION_CODE --pull ${DOCKER_ARGS} .
	docker buildx build --platform linux/amd64 --load -t '${NAME}:${VERSION}' .
	docker buildx build --platform linux/amd64 --load -t '${NAME}:${VERSION}-${TIMESTAMP}' .
	docker buildx build --platform linux/amd64 --load -t '${NAME}:${SLES_VERSION}' .
	docker buildx build --platform linux/amd64 --load -t '${NAME}:${SLES_VERSION}-${VERSION}' .
	docker buildx build --platform linux/amd64 --load -t '${NAME}:${SLES_VERSION}-${VERSION}-${TIMESTAMP}' .
