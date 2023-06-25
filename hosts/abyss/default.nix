{ pkgs, ... }:
{
  home.username = "clvx";
  home.homeDirectory = "/Users/clvx/";
  imports = [
  ../../home.nix
  ];
}
