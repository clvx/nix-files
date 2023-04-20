{ pkgs, ... }: {
  programs.home-manager.enable = true;

  home.username = "clvx";
  home.homeDirectory = "/home/clvx";
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
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      source  $HOME/nix-files/config/nvim/settings/basics.vim
      luafile $HOME/nix-files/config/nvim/settings/basics.lua
      luafile $HOME/nix-files/config/nvim/settings/whichkey.lua
      luafile $HOME/nix-files/config/nvim/settings/keymaps.lua
      luafile $HOME/nix-files/config/nvim/plugins/nvim-tree.lua
      luafile $HOME/nix-files/config/nvim/plugins/nvim-treesitter.lua
      luafile $HOME/nix-files/config/nvim/plugins/lualine-nvim.lua
      luafile $HOME/nix-files/config/nvim/plugins/nvim-lspconfig.lua
      luafile $HOME/nix-files/config/nvim/plugins/nvim-cmp.lua
      luafile $HOME/nix-files/config/nvim/plugins/toggleterm.lua
      luafile $HOME/nix-files/config/nvim/plugins/gitsigns.lua
      luafile $HOME/nix-files/config/nvim/plugins/go-nvim.lua
    '';

    plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-cue

        #colorscheme
        gruvbox

        #identation lines
        indentLine

        #File tree
        nvim-web-devicons
        nvim-tree-lua

        #eye candy
        nvim-treesitter
        lualine-nvim
        toggleterm-nvim
        which-key-nvim

        #fuzzy finder
        fzf-lua

        #git
        gitsigns-nvim

        #lsp
        nvim-lspconfig

        #completion
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp-nvim-lua
        cmp-nvim-lsp
        luasnip
        cmp_luasnip
        lspkind-nvim

        ##go
        vim-go
        #go-nvim

    ];
  };
  programs.tmux = {
    enable = true;
    sensibleOnTop = false; #removing tmux home-manager's defaults
    baseIndex = 1;
    newSession = true;
    extraConfig =  ''
      source $HOME/nix-files/config/tmux/tmux.conf
    '';
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    sessionVariables = {
      PATH = "$PATH:$HOME/Code/academy/go/bin";
      GOPATH = "$HOME/Code/academy/go";
      #FZF_DEFAULT_COMMAND = "find . -type f -not -path '*/\.git/*'";
      DOCKER_BUILDKIT = 1;
    };
    shellAliases = {
      nocomments = "grep -v \"^#'";
      noblanks = "sed \"/^$/d\"";
      nohistory = "history | sed \"s/^\s*[0-9]*\s*\(.*\)/\1/\"";
    };
    initExtra = "
      eval \"$(starship init zsh)\"
    ";
    plugins = with pkgs; [
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
          #sha256 = lib.fakeSha256; #leave hash empty if rev changes - update after it's processed
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-completions";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.34.0";
          sha256 = "sha256-qSobM4PRXjfsvoXY6ENqJGI9NEAaFFzlij6MPeTfT0o=";
          #sha256 = lib.fakeSha256; #leave hash empty if rev changes - update after it's processed
        };
        file = "zsh-syntax-highlighting.zsh";
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
      ];
    };
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    serverAliveInterval = 30;
    controlMaster = "auto";
    controlPath = "/tmp/mux-%r@%h:%p";
    controlPersist = "4h";
    serverAliveCountMax = 120;
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/id_vcs_rsa";
        identitiesOnly = true;
      };
      "gitlab.com" = {
        identityFile = "~/.ssh/id_vcs_rsa";
        identitiesOnly = true;
      };

    };

  };
}
