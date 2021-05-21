glusterfs
----

debian version by obarisk. this project was inspired by [melthaw's](https://github.com/melthaw/glusterfs-docker-compose)


## Note

If IPv6 is disabled, gluster client still trying IPv6.
To stop gluster client probe IPv6, we have to disable all IPv6 configs in `/etc/hosts`.


## how to

- build gfs-deb container image by `docker build . -t gfs-deb`
- cp `misc/hosts` to project folder
- fix `ipv4_address` in `docker-compose.yml` consistent with `hosts`
- open port 49152-49153 indicates maxmium two volumes available.
- for more volumes, add more ports
- init volume with `volume_init.sh`
