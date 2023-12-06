{ config, lib, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "void"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };
  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  users.users.clvx = {
    isNormalUser = true;
    description = "Luis M Ibarra";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      thunderbird
      spotify
      zoom-us
      todoist-electron
      telegram-desktop
      bitwarden
      slack
      
    ];
  };
  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
  ];
  services.udev.packages = with pkgs; [ 
    gnome.gnome-settings-daemon 
  ];
  services.openssh.enable = true;
  system.stateVersion = "23.05"; # Did you read the comment?
  programs.neovim.enable = true;
  programs.git.enable = true;
  programs.zsh.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;
  fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "Hack" ]; })
  ];
  nixpkgs.config.firefox.enableGnomeExtensions = true;
  services.gnome.gnome-browser-connector.enable = true;

  # following configuration is added only when building VM with 
  # nixos build-vm
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize =  4096;
      cores = 3;         
      forwardPorts = [
        { from = "host"; host.port = 2222; guest.port = 22; }
      ];
    };
  };

}
