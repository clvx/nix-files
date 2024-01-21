{ config, pkgs, lib, inputs, modulesPath, ... }: {
  zfs-root = {
    boot = {
      devNodes = "/dev/disk/by-id/";
      bootDevices = [  "nvme-eui.0025384861b61f83" ];
      immutable.enable = false;
      removableEfi = true;
      luks.enable = true;
    };
  };
  boot.zfs.forceImportRoot = false;
  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelParams = [ ];

  # read changeHostName.txt file.
  networking.hostName = "rift";

  time.timeZone = "America/Denver";

  #ZFS configs
  networking.hostId = "97dff6c2";

  ## enable ZFS auto snapshot on datasets
  ## You need to set the auto snapshot property to "true"
  ## on datasets for this to work, such as
  # zfs set com.sun:auto-snapshot=true rpool/nixos/home
  services.zfs = {
    autoSnapshot = {
      enable = false; flags = "-k -p --utc";
      monthly = 48;
    };
  };


  # import preconfigured profiles
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # (modulesPath + "/profiles/hardened.nix")
    # (modulesPath + "/profiles/qemu-guest.nix")
  ];
}
