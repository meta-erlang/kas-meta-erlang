
DL_DIR := ${HOME}/work/yocto
KAS := ${HOME}/work/opensource/kas/kas-container

ifeq (${UPDATE}, 1)
	update = --update
else
	update = 
endif

mount:
	mkdir -p yocto
	sudo mount -o bind ${DL_DIR} yocto

menu: 
	${KAS} menu

shell:
	${KAS} shell ${update}
