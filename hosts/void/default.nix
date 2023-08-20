{ pkgs, ... }:
{
  home.username = "clvx";
  home.homeDirectory = "/home/clvx";
  imports = [
  ../../config/nix/home.nix
  ];
}
