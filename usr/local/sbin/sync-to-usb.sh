#!/bin/bash -x


function clean {

	sync && sync && sync
	umount /mnt/usbroot
	umount /mnt/rootsnap
	lvremove -f /dev/memvg/root-snap
}

clean

lvcreate -s -l100%FREE -n root-snap /dev/memvg/root

mkdir -p /mnt/rootsnap
mount -o defaults,data=writeback,noatime,nodiratime,rw /dev/memvg/root-snap /mnt/rootsnap

mkdir -p /mnt/usbroot
mount -o defaults,data=writeback,noatime,nodiratime,rw /dev/disk/by-label/usbroot /mnt/usbroot

rsync --delete --inplace --no-whole-file -avh /mnt/rootsnap/* /mnt/usbroot/

clean
