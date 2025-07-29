{ pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./common.nix
    ./fzf.nix
    ./nvim.nix
    ./tmux.nix
    ./zsh.nix
  ];

}
