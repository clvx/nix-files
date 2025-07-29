{
  description = "Home‑Manager‑only flake for the vagrant user (inside your Vagrant VM).";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

  in {
    homeConfigurations.vagrant = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs system pkgs-unstable;
      };
      modules = [
        ({ config, ... }: {
          home.username      = "vagrant";
          home.homeDirectory = "/home/vagrant";
        })
        ./config/nix/home.nix
      ];
    };
    # To enable nix run .#vagrant
    packages.${system}.vagrant = self.homeConfigurations.vagrant.activationPackage;
  };

}
