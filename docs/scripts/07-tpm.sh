# nvme
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0 /dev/nvme0n1p3
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0 /dev/nvme1n1p3
# swap
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0 /dev/nvme0n1p2
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0 /dev/nvme1n1p2
# data array
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0 /dev/sda
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0 /dev/sdb
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0 /dev/sdc
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0 /dev/sdd

