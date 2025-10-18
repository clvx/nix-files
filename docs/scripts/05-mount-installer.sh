# Root for first distro (NixOS)
mount -o subvol=@nix-root,compress=zstd:3,ssd,discard=async,noatime /dev/mapper/luks-nvme0n1p3 /mnt

mkdir -p /mnt/{boot,boot/efi,nix,.snapshots}

# Shared nix store and snapshots
mount -o subvol=@nix,compress=zstd:3,ssd,discard=async,noatime /dev/mapper/luks-nvme0n1p3 /mnt/nix
mount -o subvol=@snapshots,compress=zstd:3,ssd,discard=async,noatime /dev/mapper/luks-nvme0n1p3 /mnt/.snapshots

# EFI (first disk; second can be synced later)
mkfs.vfat -n EFI0 /dev/nvme0n1p1
mount /dev/nvme0n1p1 /mnt/boot/efi
