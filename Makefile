ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
YOCTO_RELEASE := master
YOCTO_DIR := ${HOME}/work/yocto

# From https://kas.readthedocs.io/en/latest/command-line.html#environment-variables
export SSTATE_DIR := ${YOCTO_DIR}/sstate-cache/${YOCTO_RELEASE}
export DL_DIR := ${YOCTO_DIR}/downloads
export KAS_BUILD_DIR ?= ${ROOT_DIR}/build

KAS := ${HOME}/work/opensource/kas/kas-container

ifeq (${UPDATE}, 1)
	update = --update
else
	update = 
endif

mount:
	mkdir -p yocto
	sudo mount -o bind ${YOCTO_DIR} yocto

menu: 
	${KAS} menu

shell:
	${KAS} --runtime-args "--device /dev/net/tun:/dev/net/tun --cap-add=NET_ADMIN --privileged -p5984:5984" shell ${update}

shell-auh:
	KAS_BUILD_DIR=build-auh ${KAS} --runtime-args "--privileged" shell ${update}
