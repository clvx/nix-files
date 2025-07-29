{
  description = "Generic Flake for clvx/nix-files on any Linux distro based on Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";
    
    # read the environment of the process that invokes Nix - MAKES IT IMPURE
    username = builtins.getEnv "USER";
    homedir  = builtins.getEnv "HOME";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs system pkgs-unstable;
      };
      modules = [
        ({ config, ... }: {
          home.username      = username;
          home.homeDirectory = homedir;
        })
        ./config/nix/home.nix
      ];
    };
    # Run as: nix run .
    packages.${system}.default = self.homeConfigurations.${username}.activationPackage;
  };
}
