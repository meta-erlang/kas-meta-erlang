#!/bin/bash

YP_RELEASES="dunfell honister master"

for i in $YP_RELEASES; do
	echo "Binding yocto to $i"
	mkdir -p build/$i/yocto || true
	sudo mount -o bind yocto build/$i/yocto
done
