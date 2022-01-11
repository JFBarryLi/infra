#!/bin/bash
apt-get update
apt-get install -y nfs-common
apt-get install -y amazon-efs-utils
apt-get install -y nfs-utils

mkdir -p /mnt/efs/fs1

test -f "/sbin/mount.efs" && printf "\n fs-054467034aa1be2b1:/ /mnt/efs/fs1 efs tls,_netdev\n" >> /etc/fstab || printf "\n${efs_id}.efs.${region}.amazonaws.com:/ /mnt/efs/fs1 nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport,_netdev 0 0\n" >> /etc/fstab

test -f "/sbin/mount.efs" && grep -ozP 'client-info]\nsource' '/etc/amazon/efs/efs-utils.conf'; if [[ $? == 1 ]]; then printf "\n[client-info]\nsource=liw\n" >> /etc/amazon/efs/efs-utils.conf; fi;

retryCnt=15; waitTime=30; while true; do mount -a -t efs,nfs4 defaults; if [ $? = 0 ] || [ $retryCnt -lt 1 ]; then echo File system mounted successfully; break; fi; echo File system not available, retrying to mount.; ((retryCnt--)); sleep $waitTime; done;
