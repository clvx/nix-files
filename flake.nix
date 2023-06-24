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

        homeConfigurations = {
            "void" = home-manager.lib.homeManagerConfiguration {
                # Note: I am sure this could be done better with flake-utils or something
                pkgs = nixpkgs.legacyPackages.x86_64-linux;

                modules = [ ./home.nix ];
            };
            "abyss" = home-manager.lib.homeManagerConfiguration {
                # Note: I am sure this could be done better with flake-utils or something
                pkgs = nixpkgs.legacyPackages.aarch64-darwin;

                modules = [ ./home.nix ];
            };
        };
    };
}
