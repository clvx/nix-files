for d in /dev/nvme0n1 /dev/nvme1n1; do
  parted --script $d \
    mklabel gpt \
    mkpart EFI fat32 1MiB 513MiB \
    set 1 esp on \
    mkpart swap 513MiB 64.5GiB \
    mkpart luksroot 64.5GiB 100%
done

