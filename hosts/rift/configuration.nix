{ config, lib, pkgs, ... }:
{
  #Boot - using systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #zfs configs
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "43706db7"; #zfs hostId

  #Networking
  networking.hostName = "rift"; # Define your hostname.
  networking.networkmanager.enable = true;

  #Locale
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

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
  };

  #Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #Users
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
      nextcloud-client
    ];
    initialPassword = "noadmin";
  };

  #Environment
  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
  ];
  services.udev.packages = with pkgs; [ 
    gnome.gnome-settings-daemon 
  ];
  nixpkgs.config.firefox.enableGnomeExtensions = true;
  services.gnome.gnome-browser-connector.enable = true;

  #System services
  services.printing.enable = true;
  services.openssh.enable = true;
  system.stateVersion = "23.05"; # Did you read the comment?

  #Default programs
  programs.neovim.enable = true;
  programs.git.enable = true;
  programs.zsh.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  #Fonts
  fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

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
