{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    # old config
    #system = "x86_64-linux";
    #pkgs = import nixpkgs {
    #  inherit system;
    #  config = {
    #    allowUnfree = true;
    #  };
    #};
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

         # make all inputs availabe in other nix files
         inherit inputs;
        };

        modules = [
          # Root on ZFS related configuration
          # TODO: this needs to be reviewed/collapse
          ./modules

          # Configuration shared by all hosts
          # TODO: this needs to be reviewed/collapse
          ./shared/configuration.nix

          # Configuration per host
          # Specific host configuration can be overloaded in each hostname directory.
          ./hosts/${hostName}

          # home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            users = { 
              clvx = ./config/nix/home.nix;
              # add more user configurations here.
            };
          }
        ];
      };

  in {
    nixosConfigurations = {
        rift = mkHost "rift" "x86_64-linux";
        void = mkHost "rift" "x86_64-linux";
    # old config
    #  void = nixpkgs.lib.nixosSystem {
    #    specialArgs = { inherit system; };
	#    modules = [
	#      ./hosts/void/hardware-configuration.nix
    #      ./hosts/void/configuration.nix
	#      home-manager.nixosModules.home-manager 
	#      {
	#        home-manager = {
    #          useUserPackages = true;
    #          useGlobalPkgs = true;
    #          users.clvx = ./config/nix/home.nix;
	#        };
	#      }
	#    ];
    #  };
    #  rift = nixpkgs.lib.nixosSystem {
    #    specialArgs = { inherit system; };
    #    modules = [
    #      ./hosts/rift/hardware-configuration.nix
    #      ./hosts/rift/configuration.nix
    #      home-manager.nixosModules.home-manager 
    #      {
    #        home-manager = {
    #          useUserPackages = true;
    #          useGlobalPkgs = true;
    #          users.clvx = ./config/nix/home.nix;
    #        };
    #      }
    #    ];
    #  };
    };
  };
}
