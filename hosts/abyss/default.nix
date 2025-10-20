{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "abyss";

  #networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    # This is needed to auto-unlock LUKS with TPM 2 - https://discourse.nixos.org/t/full-disk-encryption-tpm2/29454/2
    tpm2-tss
    tpm2-tools
    systemdUkify
  ];

  # Set your time zone.
  time.timeZone = "America/Denver";

  nix = {
    settings = {
      substituters = [
        "http://binarycache.bitclvx.com"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "binarycache.bitclvx.com:VGscmPOVYLtm4geoKwHWo7KU+ehd5DjhbZBjYw1yips=%"
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  networking = {
    extraHosts =
    ''
      192.168.88.254 binarycache.bitclvx.com
      192.168.1.1 www.routerlogin.net
    '';
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  system.stateVersion = "25.05"; # Did you read the comment?
}
