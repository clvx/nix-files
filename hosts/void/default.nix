{ config, lib, pkgs, pkgs-unstable, modulesPath, ... }:
{
 # import preconfigured profiles
 imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./networking.nix
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


  services = {
    ## enable ZFS auto snapshot on datasets
    ## You need to set the auto snapshot property to "true"
    ## on datasets for this to work, such as
    # zfs set com.sun:auto-snapshot=true rpool/nixos/home
    zfs = {
      autoSnapshot = {
        enable = false; flags = "-k -p --utc";
        monthly = 48;
      };
    };
    #LLM - https://wiki.nixos.org/wiki/Ollama
    ollama = {
      package = pkgs-unstable.ollama;
      enable = true;
    };
  };
}
