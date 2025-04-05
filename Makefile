ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
YOCTO_RELEASE := master
YOCTO_DIR := /data-work/yocto

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

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#' $(MAKEFILE_LIST) | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

menu: # Open kas menu 
	${KAS} menu

shell: # Start a kas shell
	${KAS} --runtime-args \
		"--mount src=/dev/kvm,dst=/dev/kvm,type=bind \
		 --device /dev/net/tun:/dev/net/tun \
		 --cap-add=NET_ADMIN \
		 --privileged \
		 -p5984:5984" \
		shell ${update}

shell-update: # Start a kas shell and update all repos
	$(MAKE) shell UPDATE=1

shell-auh: # Start kas shell suitable for AUH	
	KAS_BUILD_DIR=build-auh ${KAS} --runtime-args "--privileged" shell ${update}
