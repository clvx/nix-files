mkfs.btrfs -L root-raid1 -m raid1 -d raid1 \
  /dev/mapper/luks-nvme0n1p3 /dev/mapper/luks-nvme1n1p3
mount /dev/mapper/luks-nvme0n1p3 /mnt

