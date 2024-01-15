#https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/Root%20on%20ZFS.html

#DISK='/dev/disk/by-id/ata-FOO /dev/disk/by-id/nvme-BAR'
DISK=''

echo "Creating Mount dir'
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
 mkpart EFI 2MiB 1GiB \
 mkpart NIXBOOT 1GiB 5GiB \
 mkpart NIXROOT 5GiB -$((SWAPSIZE + RESERVE))GiB \
 mkpart swap  -$((SWAPSIZE + RESERVE))GiB -"${RESERVE}"GiB \
 mkpart BIOS 1MiB 2MiB \
 set 1 esp on \
 set 5 bios_grub on \
 set 5 legacy_boot on

 partprobe "${disk}"
 udevadm settle
}

echo "partitioning disk"
for i in ${DISK}; do
   partition_disk "${i}"
done

echo "creating encrypted swap"
for i in ${DISK}; do
   cryptsetup open --type plain --key-file /dev/random "${i}"-part4 "${i##*/}"-part4
   mkswap /dev/mapper/"${i##*/}"-part4
   swapon /dev/mapper/"${i##*/}"-part4
done

echo "enabling Luks on root"
for i in ${DISK}; do
   # see PASSPHRASE PROCESSING section in cryptsetup(8)
   printf "YOUR_PASSWD" | cryptsetup luksFormat --type luks2 "${i}"-part3 -
   printf "YOUR_PASSWD" | cryptsetup luksOpen "${i}"-part3 luks-NIXROOT-"${i##*/}"-part3 -
done


echo "creating NIXBOOT"
# shellcheck disable=SC2046
zpool create -o compatibility=legacy  \
    -o ashift=12 \
    -o autotrim=on \
    -O acltype=posixacl \
    -O canmount=off \
    -O devices=off \
    -O normalization=formD \
    -O relatime=on \
    -O xattr=sa \
    -O mountpoint=/boot \
    -R "${MNT}" \
    NIXBOOT \
  #mirror \ #uncomment this line for mirror
    $(for i in ${DISK}; do
       printf '%s ' "${i}-part2";
      done)

echo "creating NIXROOT"
# shellcheck disable=SC2046
zpool create \
    -o ashift=12 \
    -o autotrim=on \
    -R "${MNT}" \
    -O acltype=posixacl \
    -O canmount=off \
    -O compression=zstd \
    -O dnodesize=auto \
    -O normalization=formD \
    -O relatime=on \
    -O xattr=sa \
    -O mountpoint=/ \
    NIXROOT \
    #mirror \ #uncomment this line for mirror
   $(for i in ${DISK}; do
      printf '/dev/mapper/luks-NIXROOT-%s ' "${i##*/}-part3";
     done)


echo "mounting NIXROOT"
zfs create -o mountpoint=legacy -p NIXROOT/nixos/root
mount -t zfs NIXROOT/nixos/root "${MNT}"/
zfs create -o mountpoint=legacy NIXROOT/nixos/home
mkdir "${MNT}"/home
mount -t zfs NIXROOT/nixos/home "${MNT}"/home
zfs create -o mountpoint=none   NIXROOT/nixos/var
zfs create -o mountpoint=legacy NIXROOT/nixos/var/lib
zfs create -o mountpoint=legacy NIXROOT/nixos/var/log
zfs create -o mountpoint=none NIXBOOT/nixos
zfs create -o mountpoint=legacy NIXBOOT/nixos/root
mkdir "${MNT}"/boot
mount -t zfs NIXBOOT/nixos/root "${MNT}"/boot
mkdir -p "${MNT}"/var/log
mkdir -p "${MNT}"/var/lib
mount -t zfs NIXROOT/nixos/var/lib "${MNT}"/var/lib
mount -t zfs NIXROOT/nixos/var/log "${MNT}"/var/log
zfs create -o mountpoint=legacy NIXROOT/nixos/empty
zfs snapshot NIXROOT/nixos/empty@start

echo "mounting NIXBOOT"
for i in ${DISK}; do
 mkfs.vfat -n EFI "${i}"-part1
 mkdir -p "${MNT}"/boot/efis/"${i##*/}"-part1
 mount -t vfat -o iocharset=iso8859-1 "${i}"-part1 "${MNT}"/boot/efis/"${i##*/}"-part1
done
