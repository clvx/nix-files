{ pkgs, pkgs-unstable, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    package = pkgs-unstable.neovim-unwrapped;
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
      luafile $HOME/nix-files/config/nvim/plugins/git-blame.lua
      luafile $HOME/nix-files/config/nvim/plugins/noice-nvim.lua
      luafile $HOME/nix-files/config/nvim/plugins/codecompanion-nvim.lua
    '';

    plugins = with pkgs-unstable.vimPlugins; [
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
        lualine-nvim
        toggleterm-nvim
        which-key-nvim
        noice-nvim
        nvim-notify
        nui-nvim

        #fuzzy finder
        fzf-lua

        #git
        gitsigns-nvim
        git-blame-nvim
        vim-fugitive

        #lsp
        nvim-lspconfig
        lspsaga-nvim

        #completion
        plenary-nvim
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp-nvim-lua
        cmp-nvim-lsp
        cmp-cmdline
        luasnip
        cmp_luasnip

        #ai
        copilot-vim
        codecompanion-nvim


        ##go
        #vim-go
        go-nvim
        nvim-dap
        nvim-dap-go
        nvim-dap-ui
        #go custom plugins
        #(pkgs-unstable.vimUtils.buildVimPlugin {
        #  name = "guihua";
        #  src = pkgs.fetchFromGitHub {
        #    owner = "ray-x";
        #    repo = "guihua.lua";
        #    rev = "d783191eaa75215beae0c80319fcce5e6b3beeda"; # or whatever branch you want to build
        #    hash = "sha256-XpUsbj1boDfbyE8C6SdOvZdkd97682VVC81fvQ5WA/4=";
        #  };
        #})

        ##python

        ##rust
        ### https://www.youtube.com/watch?v=E2mKJ73M9pg
        ### https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
        rustaceanvim


        #treesitter
        nvim-treesitter
        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
        nvim-treesitter-context
        
    ];
  };

}
