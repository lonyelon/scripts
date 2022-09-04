#!/bin/sh

# This script syncs my data folders for backups. It automatically omits
# unnecessary files and directories.
#
# Made by LONYELON (lonyelon@lony.xyz) for personal use, 2021.

user="lonyelon"
group="lonyelon"

rsync $3 -av \
	--exclude='*.iso' \
	--exclude='*.raw' \
	--exclude='*.qcow2' \
	--exclude='*.img' \
	--exclude='*.vs*' \
	--exclude='*id_rsa*' \
	--exclude='*Cache*' \
	--exclude='*cache*' \
	--exclude='*Trash*' \
	--exclude='*trash*' \
	--exclude='*Log*' \
	--exclude='*log*' \
	--exclude='*Tmp*' \
	--exclude='*Temp*' \
	--exclude='*tmp*' \
	--exclude='*temp*' \
	--exclude='*Steam*' \
	--exclude='*steam*' \
	--exclude='*Daedalus*' \
	--exclude='*daedalus*' \
	--exclude='*Monero*' \
	--exclude='*monero*' \
	--exclude='*node_modules*' \
	--exclude='*.local/share/qutebrowser*' \
	--exclude='*systemd/coredump*' \
	--exclude='*docker/overlay2*' \
	--exclude='*docker/volumes*' \
	$1 $2 2> /dev/null

chown -R $user:$group $2
