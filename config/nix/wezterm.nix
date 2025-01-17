{ pkgs, ...}:

{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = builtins.readFile ../files/wezterm.lua;
  };

  #home.file."wezterm" = {
  #  recursive = true;
  #  source = ../files/wezterm-config;
  #  target = ".config/wezterm/wezterm.lua";
  #};

}
