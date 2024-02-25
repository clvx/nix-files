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
      wl-clipboard
    ];
    initialPassword = "noadmin";
  };

  #Environment
  # environment.SystemPackages requires an attribute set which means any 
  # function that can return an attribute set can be called as a value like 
  # buildints.attrValues {
  #  inherit (pkgs)
  #  myPackage
  #  ;
  #  inherit (pkgs-unstable)
  #  myPackage
  #  ;
  #};.
  # Also, as long as statement inside the list returns an element for the 
  # attribute, it will valid like
  # = [ 
  #    ...
  #    (builtins.getFlake "flake-url")
  #    ...
  #   ];
  # Review https://nixos.org/manual/nix/stable/language/constructs 
  environment.systemPackages = [
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.appindicator
    pkgs.libreoffice-qt
    pkgs-unstable.gnomeExtensions.ddterm
    pkgs-unstable.gnomeExtensions.vitals
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-music
    gedit # text editor
    epiphany # web browser
    geary # email reader
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  # Also, a custom package can be built and pass as a single package: 
  # https://nixos.org/manual/nixos/stable/#sec-custom-packages
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
    steam.enable = true;
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
