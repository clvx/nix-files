{ pkgs, ... }:
{
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
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
    pkgs.mockgen
    pkgs.golangci-lint
    pkgs.gotools
    pkgs.govulncheck
    pkgs.gomodifytags
    pkgs.gotests
    pkgs.iferr
    pkgs.impl
    pkgs.reftools
    pkgs.delve
    pkgs.richgo
    pkgs.gofumpt
    pkgs.gotestsum
    pkgs.golines

    #language servers
    pkgs.gopls
    pkgs.pyright
    pkgs.sumneko-lua-language-server
    pkgs.rnix-lsp
    pkgs.vscode-langservers-extracted

    #other packages
    #pkgs.terraform
    pkgs.kind
    pkgs.kubectl
    pkgs.kubeswitch
    pkgs.direnv
  ];

}
