{ pkgs, ... }: {
  programs.home-manager.enable = true;

  home.username = "clvx";
  home.homeDirectory = "/home/clvx";
  home.stateVersion = "22.11";

  home.packages = [
        pkgs.cowsay
        pkgs.fzf
        pkgs.ripgrep
        pkgs.tree
        pkgs.jq
	pkgs.tmux
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      luafile ./config/nvim/settings/basics.lua
      luafile ./config/nvim/plugins/nvim-tree.lua
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
    ];
  };

}
