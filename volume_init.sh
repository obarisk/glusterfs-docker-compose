#!/usr/bin/env bash

MYVOLUME=gluster
XUID=1000
XGID=1000

# NOTE: this is configed in hosts
docker-compose exec gluster01 gluster peer probe gluster02
docker-compose exec gluster01 gluster peer probe glusterab

docker-compose exec gluster01 gluster volume info ${MYVOLUME} || \
  (
  docker-compose exec gluster01 gluster volume \
    create ${MYVOLUME} replica 2 arbiter 1 \
    transport tcp \
    gluster01:/data/glusterfs/${MYVOLUME} \
    gluster02:/data/glusterfs/${MYVOLUME} \
    glusterab:/data/glusterfs/${MYVOLUME}
    sleep 3
    docker-compose exec gluster01 gluster volume start ${MYVOLUME}
    docker-compose exec gluster01 gluster volume set ${MYVOLUME} diagnostics.brick-log-level ERROR
    docker-compose exec gluster01 gluster volume set ${MYVOLUME} diagnostics.client-log-level ERROR
    docker-compose exec gluster01 gluster volume set ${MYVOLUME} server.allow-insecure ON
    docker-compose exec gluster01 gluster volume set ${MYVOLUME} storage.owner-uid ${XUID}
    docker-compose exec gluster01 gluster volume set ${MYVOLUME} storage.owner-gid ${XGID}
    docker-compose exec gluster01 gluster volume info
  )
