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
    ##go
    pkgs.go
    pkgs.golangci-lint
    pkgs.govulncheck
    pkgs.gomodifytags
    pkgs.gotests
    pkgs.richgo
    pkgs.gofumpt
    pkgs.gotestsum
    pkgs.golines
    ##python
    pkgs.pyenv
    pkgs.python3
    pkgs.uv
    ##rust-analyzer
    pkgs.rustc
    pkgs.cargo
    pkgs.rustfmt
    pkgs.clippy
    ##others
    pkgs.mockgen
    pkgs.iferr
    pkgs.impl
    pkgs.reftools
    pkgs.delve

    #language servers
    pkgs.gopls
    pkgs.pyright
    pkgs.ruff
    pkgs.lua-language-server
    pkgs.nil
    pkgs.nixd
    pkgs.vscode-langservers-extracted
    pkgs.rust-analyzer
    pkgs.typescript-language-server

    
    #other packages
    pkgs.kind
    pkgs.kubectl
    pkgs.kubeswitch
    pkgs.direnv
    pkgs.gh

    pkgs.vagrant
    pkgs.docker-compose

    #network
    pkgs.whois
    pkgs.mtr
    pkgs.dig
    pkgs.nmap
    pkgs.tcpdump
  ];
}
