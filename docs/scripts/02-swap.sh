for d in /dev/nvme0n1p2 /dev/nvme1n1p2; do
  cryptsetup luksFormat --type luks2 "$d"
  cryptsetup open "$d" luks-$(basename $d)
  systemd-cryptenroll --tpm2-device=auto "$d"
  mkswap /dev/mapper/luks-$(basename $d)
done
