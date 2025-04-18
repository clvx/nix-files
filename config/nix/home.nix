{ pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./common.nix
    ./fzf.nix
    ./nvim.nix
    ./ssh.nix
    ./tmux.nix
    ./zsh.nix
    ./git.nix
    ./wezterm.nix
    ./vscode.nix
  ];

}
