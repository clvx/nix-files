{ pkgs, ... }:
{
  home.username = "clvx";
  home.homeDirectory = "/home/clvx/";
  imports = [
  ../../home.nix
  ];
}
