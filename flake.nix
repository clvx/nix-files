{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # optional, not necessary for the module
    # optionally choose not to download darwin deps (saves some resources on Linux)
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, agenix, ... }@inputs:
  let
    mkHost = hostName: system:
      nixpkgs.lib.nixosSystem {
        #Had no f*cking idea you could just pass pkgs in this code block
        pkgs = import nixpkgs {
          inherit system;
          # settings to nixpkgs goes to here
          config = {
            allowUnfree = true;
          };
        };

        specialArgs = {
          # By default, the system will only use packages from the
          # stable channel.  You can selectively install packages
          # from the unstable channel.  You can also add more
          # channels to pin package version.
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            # settings to nixpkgs-unstable goes to here
            config = {
              allowUnfree = true;
            };
          };

         # make all inputs and system availabe in other nix files
         # https://discourse.nixos.org/t/how-to-pass-variables-to-a-module-defined-in-a-flake-nix-file/33125/2
         inherit inputs system self;
        };

        modules = [
          # Root on ZFS related configuration
          #./modules

          agenix.nixosModules.default

          # Configuration shared by all hosts
          ./shared/configuration.nix

          # Configuration per host
          # Specific host configuration can be overloaded in each hostname directory.
          ./hosts/${hostName}

          # home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                clvx = ./config/nix/home.nix;
                # add more user configurations here.
              };
              extraSpecialArgs = { 
                inherit inputs system self nixpkgs-unstable;
                pkgs-unstable = import nixpkgs-unstable { 
                  inherit system; 
                  config.allowUnfree = true; 
                }; 
              };
	        };
          }
        ];
      };
  in {
    nixosConfigurations = {
      rift = mkHost "rift" "x86_64-linux";
      void = mkHost "void" "x86_64-linux";
      abyss = mkHost "abyss" "x86_64-linux";
    };
  };
}
