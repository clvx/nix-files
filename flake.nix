{
  description = "My Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

    outputs = {nixpkgs, home-manager, ...}: {
        defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
        defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;
        defaultPackage.aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;

        homeConfigurations = {
            "void" = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
                modules = [ ./hosts/void/default.nix ];
            };
            "abyss" = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.aarch64-darwin;
                modules = [ ./hosts/abyss/default.nix ];
            };
        };
    };
  };
}
