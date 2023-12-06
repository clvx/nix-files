{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

  in {
    nixosConfigurations = {
      void = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
	    modules = [
	      ./hardware-configuration.nix
          ./configuration.nix
	      home-manager.nixosModules.home-manager 
	      {
	        home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.clvx = ./config/nix/home.nix;
	        };
	      }
	    ];
      };
    };
  };
}
