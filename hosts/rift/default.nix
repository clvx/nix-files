{ lib, pkgs, modulesPath, ... }:
{
 # import preconfigured profiles
 imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (modulesPath + "/installer/scan/not-detected.nix")
      # (modulesPath + "/profiles/hardened.nix")
      # (modulesPath + "/profiles/qemu-guest.nix")
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #This is good
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];

  networking.hostName = "rift";
  #networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";


}
