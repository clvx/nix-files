# configuration in this file is shared by all hosts

# review ./modules for hw boot config
# review ./hosts/${host}/default.nix for specifics.

# TODO: a few things to improve
# - Boot options could vary as some hosts and cloud based deployments might not use zfs. Maybe push the filesystem options per host on in modules.
# - gui settings should be a module as cloud based deployments might not use a GUI. Same with sound and vm's.

{ pkgs, pkgs-unstable, inputs, ... }:
let inherit (inputs) self;
in {

  #Networking
  networking.networkmanager.enable = true;

  #Locale
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

  #GUI
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
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
    #"gnomeExtensions.dash-to-dock"
    #"gnomeExtensions.appindicator"
    ;
    # By default, the system will only use packages from the
    # stable channel. i.e.
    # inherit (pkg) my-favorite-stable-package;
    # You can selectively install packages
    # from the unstable channel. Such as
    # inherit (pkgs-unstable) my-favorite-unstable-package;
    # You can also add more
    # channels to pin package version.
  };
  services.udev.packages = with pkgs; [ 
    gnome.gnome-settings-daemon 
  ];
  #nixpkgs.confeg.firefx.enableGnomeExtensions = true;
  services.gnome.gnome-browser-connector.enable = true;

  #Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  #System services
  services = {
    printing.enable = true;
    openssh = {
      enable = true;
      #settings = { PasswordAuthentication = false; };
    };
  };
  system.stateVersion = "23.11"; # Did you read the comment?

  #Default programs
  programs = { 
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
    git.enable = true;
    zsh.enable = true;
  };

  nix.settings.experimental-features = "nix-command flakes";

  ## Safety mechanism: refuse to build unless everything is
  ## tracked by git
  #system.configurationRevision = if (self ? rev) then
  #  self.rev
  #else
  #  throw "refuse to build: git tree is dirty";

  # let nix commands follow system nixpkgs revision
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  # you can then test any package in a nix shell, such as
  # $ nix shell nixpkgs#neovim

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
