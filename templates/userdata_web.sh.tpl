#!/bin/bash
apt-get update -y
apt-get install nfs-common -y
mkdir /${os_mount_point}
mount -t nfs -o nolock,hard ${sgw_ip}:/${sgw_export_path} /${os_mount_point}