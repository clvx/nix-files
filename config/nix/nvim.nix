{ pkgs, ... }:
{
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

}
