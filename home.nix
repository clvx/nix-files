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
      luafile ./config/nvim/settings/basics.lua
      luafile ./config/nvim/plugins/nvim-tree.lua
      luafile ./config/nvim/plugins/nvim-treesitter.lua
      luafile ./config/nvim/plugins/lualine-nvim.lua
      luafile ./config/nvim/plugins/nvim-lspconfig.lua
      luafile ./config/nvim/plugins/nvim-cmp.lua
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
