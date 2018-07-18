# DHCP CNI Plugin container

This repo is the source for the opensourcelan/dhcp-cni-plugin docker image.

### How to use

Step 1: Make sure the bridge interface `br0` is configured on *every* host
in your kube cluster. This needs to be bridged with your LAN that serves
the DHCP you want.

Step 2: `kubectl apply -f dhcp-daemonset.yaml`

Done! The daemonset will deploy the CNI config and the requisite
DHCP daemon.

### How to build

Step 1: Build the `dhcp` binary.

```
GOPATH=~/go go get github.com/containernetworking/plugins/plugins/ipam/dhcp
cd ~/go/src/github.com/containernetworking/plugins/plugins/ipam/dhcp
CGO_ENABLED=1 go build
```

Step 2: Put the `dhcp` binary in to this folder

```
cp ~/go/src/github.com/containernetworking/plugins/plugins/ipam/dhcp/dhcp .
```

Step 3: Build the image

```
./build.sh
```



