FROM debian:bullseye
RUN apt update && \
    apt install -y glusterfs-server 

RUN mkdir -p /pkg_orig/etc /pkg_orig/lib && \
    cp -r /etc/glusterfs/*     /pkg_orig/etc && \
    cp -r /var/lib/glusterd/*  /pkg_orig/lib

VOLUME ["/etc/glusterfs"]
VOLUME ["/var/lib/glusterd"]
VOLUME ["/var/log/glusterfs"]

ADD entry_point.sh /entry_point.sh

RUN chmod +x /entry_point.sh

# EXPOSE 111 245 24007 2049 6010 6011 6012 38465 38466 38468 38469 49152 49153 49154 49156 49157 49158 49159 49160 49161 49162
EXPOSE 24007 24008 49152 49153

ENTRYPOINT ["/entry_point.sh"]

CMD ["glusterd", "-N", "--log-level", "WARNING"]
