{ pkgs, ... }:
{
  programs.home-manager.enable = true;

  home.stateVersion = "22.11";
  home.sessionVariables = {
    SHELL = "zsh";
    EDITOR = "nvim";
  };

  #TODO:
  # add sessionVariables = {};
  # add shellAliases = {};
  # add git configs

  home.packages = [
    #must haves
    pkgs.cowsay
    pkgs.ripgrep
    pkgs.tree
    pkgs.jq
    pkgs.gcc
    pkgs.bat
    pkgs.z-lua
    pkgs.hey

    #prompt
    pkgs.starship

    #programming languages
    pkgs.go

    #language servers
    pkgs.gopls
    pkgs.pyright
    pkgs.sumneko-lua-language-server
    pkgs.rnix-lsp

    #other packages
    pkgs.terraform
    pkgs.kind
    pkgs.kubectl
    pkgs.kubeswitch
    pkgs.direnv
  ];

}
