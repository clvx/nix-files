for d in /dev/nvme0n1p3 /dev/nvme1n1p3; do
  cryptsetup luksFormat --type luks2 "$d"
  cryptsetup open "$d" luks-$(basename $d)
  systemd-cryptenroll --tpm2-device=auto "$d"
done

