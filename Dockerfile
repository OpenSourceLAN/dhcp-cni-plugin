FROM busybox

ADD dhcp /dhcp

VOLUME ["/run"]
USER root
CMD ["/dhcp", "daemon"]
