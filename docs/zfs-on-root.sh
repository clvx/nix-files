#https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/Root%20on%20ZFS.html

#void
#DISK='/dev/disk/by-id/nvme-eui.002538b81150152a /dev/disk/by-id/nvme-eui.002538ba115083f3'

#rift
#DISK='/dev/disk/by-id/nvme-eui.0025384861b61f83'


echo "Creating Mount dir"
MNT=$(mktemp -d)
SWAPSIZE=4
RESERVE=1

echo "enabling flakes"
#enable Nix Flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

echo "installing dependencies"
#install installation dependencies
if ! command -v git; then nix-env -f '<nixpkgs>' -iA git; fi
if ! command -v partprobe;  then nix-env -f '<nixpkgs>' -iA parted; fi

partition_disk () {
 local disk="${1}"
 blkdiscard -f "${disk}" || true

 parted --script --align=optimal  "${disk}" -- \
 mklabel gpt \
 mkpart EFI 1MiB 4GiB \
 mkpart rpool 4GiB -$((SWAPSIZE + RESERVE))GiB \
 mkpart swap  -$((SWAPSIZE + RESERVE))GiB -"${RESERVE}"GiB \
 set 1 esp on \

 partprobe "${disk}"
}

echo "partitioning disks"
for i in ${DISK}; do
   partition_disk "${i}"
done

echo "creating encrypted swap"
for i in ${DISK}; do
   cryptsetup open --type plain --key-file /dev/random "${i}"-part3 "${i##*/}"-part3
   mkswap /dev/mapper/"${i##*/}"-part3
   swapon /dev/mapper/"${i##*/}"-part3
done

echo "enabling Luks on root"
for i in ${DISK}; do
   # see PASSPHRASE PROCESSING section in cryptsetup(8)
   printf "PASSWD" | cryptsetup luksFormat --type luks2 "${i}"-part2 -
   printf "PASSWD" | cryptsetup luksOpen "${i}"-part2 luks-rpool-"${i##*/}"-part2 -
done

echo "creating rpool"
# shellcheck disable=SC2046
zpool create \
    -o ashift=12 \
    -o autotrim=on \
    -R "${MNT}" \
    -O acltype=posixacl \
    -O canmount=off \
    -O dnodesize=auto \
    -O normalization=formD \
    -O relatime=on \
    -O xattr=sa \
    -O mountpoint=none \
    rpool \
    mirror \
   $(for i in ${DISK}; do
      printf '/dev/mapper/luks-rpool-%s ' "${i##*/}-part2";
     done)

echo "create root system container"
zfs create -o canmount=noauto -o mountpoint=legacy rpool/root

echo "create system datasets"
zfs create -o mountpoint=legacy rpool/home
mount -o X-mount.mkdir -t zfs rpool/root "${MNT}"
mount -o X-mount.mkdir -t zfs rpool/home "${MNT}"/home

echo "format and mount ESP - this needs mirroring as only one is used as /boot"
for i in ${DISK}; do
 mkfs.vfat -n EFI "${i}"-part1
done

for i in ${DISK}; do
 mount -t vfat -o fmask=0077,dmask=0077,iocharset=iso8859-1,X-mount.mkdir "${i}"-part1 "${MNT}"/boot
 break
done
