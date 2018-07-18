#!/bin/bash

gettimestamp() {
	date +%Y%m%d-%H%M%S
}

[[ ! -f dhcp ]] && echo "you need to build the dhcp binary before building the image" && exit 1

BASENAME="opensourcelan/dhcp-cni-plugin"

docker build -t $BASENAME:latest -t $BASENAME:$(gettimestamp) .

