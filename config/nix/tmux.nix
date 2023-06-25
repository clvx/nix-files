{
  programs.tmux = {
    enable = true;
    sensibleOnTop = false; #removing tmux home-manager's defaults
    baseIndex = 1;
    newSession = true;
    extraConfig =  ''
      source $HOME/nix-files/config/tmux/tmux.conf
    '';
  };
}
