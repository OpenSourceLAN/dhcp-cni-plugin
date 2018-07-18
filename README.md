# DHCP CNI Plugin container

This repo is the source for the [opensourcelan/dhcp-cni-plugin docker image](https://hub.docker.com/r/opensourcelan/dhcp-cni-plugin/).

### How to use

Step 0: **Important**: 

You need to enable ip_forwarding on all of your kube hosts first. This is not done by
the container because if ip_forwarding is not set when docker starts, docker will set
it _and_ set a default iptables forward policy of `drop`, which breaks everything.

```
cat <<EOF >/etc/sysctl.d/05-forwarding.conf 
net.ipv4.ip_forward=1
EOF
sysctl --load=/etc/sysctl.d/05-forwarding.conf 
```

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
GOPATH=~/go CGO_ENABLED=0 go build
```

Step 2: Put the `dhcp` binary in to this folder

```
cp ~/go/src/github.com/containernetworking/plugins/plugins/ipam/dhcp/dhcp .
```

Step 3: Build the image

```
./build.sh
```



