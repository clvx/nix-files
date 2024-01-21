{ config, pkgs, lib, inputs, modulesPath, ... }: {
  zfs-root = {
    boot = {
      devNodes = "#TBD";
      bootDevices = [  "TBD" ];
      immutable.enable = false;
      removableEfi = true;
      luks.enable = true;
    };
  };
  boot.zfs.forceImportRoot = false;
  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "kernelModules_placeholder" ];
  boot.kernelParams = [ ];

  # read changeHostName.txt file.
  networking.hostName = "rift";

  time.timeZone = "America/Denver";

  #ZFS configs
  networking.hostId = "639fbcd5";

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
