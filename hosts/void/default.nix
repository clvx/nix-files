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

  environment.systemPackages = with pkgs; [  btrfs-progs cryptsetup ];

  time.timeZone = "America/Denver";

  programs = {
    steam.enable = true;
  };

  system.stateVersion = "25.05"; # Did you read the comment?

}
