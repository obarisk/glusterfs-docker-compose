#!/usr/bin/env bash

[[ -f "/etc/glusterfs/.glusterfs-docker" ]] || (
  cp -r /pkg_orig/etc/* /etc/glusterfs
  touch /etc/glusterfs/.glusterfs-docker
)

[[ -f "/var/lib/glusterd/.glusterfs-docker" ]] || (
  cp -r  /pkg_orig/lib/* /var/lib/glusterd/
  touch /var/lib/glusterd/.glusterfs-docker
)

exec "$@"
