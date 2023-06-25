{ pkgs, ... }:
{
  home.username = "clvx";
  home.homeDirectory = "/Users/clvx/";
  imports = [
  ../../config/nix/home.nix
  ];
}
