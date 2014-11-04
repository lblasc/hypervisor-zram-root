hypervisor-zram-root
====================

Configuration files for booting root file system from [snapshottable] Logical volume (LV)
which Volume group (VG) resides on [zram] (compressed in memory block device).

Conf files are based on Debian Wheezy.

HOWTO
-----

### USB stick setup

```
# http://blogofterje.wordpress.com/2012/01/14/optimizing-fs-on-sd-card/
mkfs.ext4 -O ^has_journal -E stride=2,stripe-width=1024 -b 4096 -L usbroot /dev/sdf1
mount -o defaults,data=writeback,noatime,nodiratime,rw /dev/sdf1 /mnt/debian
debootstrap --arch=amd64 --include=vim,vlan,bridge-utils wheezy /mnt/debian http://http.debian.net/debian
mount --bind /sys /mnt/debian/sys
mount --bind /dev /mnt/debian/dev
mount -t proc none /mnt/debian/proc
chroot /mnt/debian /bin/bash
```
TBD
---

[zram]:https://www.kernel.org/doc/Documentation/blockdev/zram.txt
[Snapshottable]:https://www.kernel.org/doc/Documentation/device-mapper/snapshot.txt
