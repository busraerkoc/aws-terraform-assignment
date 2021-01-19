#!/bin/bash
apt-get update
apt-get install nfs-common -y
mkdir /${os_mount_point}
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_mount_target}:/ /${os_mount_point}