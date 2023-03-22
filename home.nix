{ pkgs, ... }: {
  programs.home-manager.enable = true;

  home.username = "clvx";
  home.homeDirectory = "/home/clvx";
  home.stateVersion = "22.11";

  home.packages = [
    #must haves
    pkgs.cowsay
    pkgs.fzf
    pkgs.ripgrep
    pkgs.tree
    pkgs.jq
    pkgs.tmux
    pkgs.gcc
    pkgs.bat
    pkgs.z-lua

    #programming languages
    pkgs.go

    #language servers
    pkgs.gopls
    pkgs.pyright
    pkgs.sumneko-lua-language-server
    pkgs.rnix-lsp
  ];

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
    ];
  };
}

