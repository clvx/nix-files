{ config, lib, pkgs, pkgs-unstable, modulesPath, ... }:
{
 # import preconfigured profiles
 imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./networking.nix
      ./services.nix
      (modulesPath + "/installer/scan/not-detected.nix")
      # (modulesPath + "/profiles/hardened.nix")
      # (modulesPath + "/profiles/qemu-guest.nix")
    ];

  #TODO: this boot options need to be updated
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #This is good
  boot.initrd.availableKernelModules = [ 
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
    #used by cilium
    "ip6table_mangle"
    "ip6table_raw"
  ];

  time.timeZone = "America/Denver";

  programs = {
    steam.enable = true;
  };

  system.stateVersion = "23.11"; # Did you read the comment?

}
