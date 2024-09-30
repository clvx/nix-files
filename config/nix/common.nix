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
    pkgs.gnumake
    pkgs.wget

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
    pkgs.lua-language-server
    pkgs.nil
    pkgs.vscode-langservers-extracted

    #python
    pkgs.pyenv
    pkgs.python3
    
    #other packages
    pkgs.kind
    pkgs.kubectl
    pkgs.kubeswitch
    pkgs.direnv

    pkgs.vagrant

    #network
    pkgs.whois
    pkgs.mtr
    pkgs.dig
    pkgs.nmap
    pkgs.tcpdump

  ];

}
