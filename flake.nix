{
  description = "Fortydeux NixOS System and Home-manager Flake";

# Flake.nix

  inputs = {
  	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  	home-manager.url = "github:nix-community/home-manager/master";
  	home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; 
    };
  
  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {    
      nixosConfigurations = {
        #--Archerfish host--#
      	archerfish-nixos = lib.nixosSystem {
    	  	inherit system;
    	  	modules = [ 
    	  	  ./nixos-config/hosts/archerfish/configuration.nix 
    	  	  #MS-Surface-specific modules:
     	  	  # nixos-hardware.nixosModules.microsoft-surface-pro-intel
            home-manager.nixosModules.home-manager
          {
            xdg.portal.wlr.enable = lib.mkForce true; # Adjust based on your preference
            # Surface-specific options
              # microsoft-surface = {
              #   surface-control.enable = true;
              #   ipts.enable = true;
              # };
          }
            ];
    	};
        #--Pufferfish host--#
      	pufferfish-nixos = lib.nixosSystem {
    	  	inherit system;
    	  	modules = [ 
    	  	  ./nixos-config/hosts/pufferfish/configuration.nix 
            nixos-hardware.nixosModules.apple-imac
            home-manager.nixosModules.home-manager
          {
            xdg.portal.wlr.enable = lib.mkForce true; # Adjust based on your preference
          }
             ];
    	};
        #--Blackfin host--#
      	blackfin-nixos = lib.nixosSystem {
    	  	inherit system;
    	  	modules = [ 
    	  	  ./nixos-config/hosts/blackfin/configuration.nix 
            home-manager.nixosModules.home-manager
          {
            xdg.portal.wlr.enable = lib.mkForce true; # Adjust based on your preference
          }
             ];
    	};
        #--Blacktetra host--#
        blacktetra-nixos = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./nixos-config/hosts/blacktetra/configuration.nix 
            home-manager.nixosModules.home-manager
          {
            xdg.portal.wlr.enable = lib.mkForce true; # Adjust based on your preference
          }
          ];
        }; 

      };

      ##--Home-Manager Configuration--##     
      homeConfigurations = {
        "fortydeux@archerfish-nixos" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Pass inputs as extraSpecialArgs
            extraSpecialArgs = { inherit inputs; };

            # Import home.nix
    	    modules = [
              ./home-manager/hosts/archerfish-home.nix
            ];
        }; 
        "fortydeux@pufferfish-nixos" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Pass inputs as extraSpecialArgs
            extraSpecialArgs = { inherit inputs; };

            # Import home.nix
    	    modules = [
              ./home-manager/hosts/pufferfish-home.nix
            ];
        }; 
        "fortydeux@blackfin-nixos" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Pass inputs as extraSpecialArgs
            extraSpecialArgs = { inherit inputs; };

            # Import home.nix
    	    modules = [
              ./home-manager/hosts/blackfin-home.nix
            ];
        };
        "fortydeux@blacktetra-nixos" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Pass inputs as extraSpecialArgs
            extraSpecialArgs = { inherit inputs; };

            # Import home.nix
            modules = [
              ./home-manager/hosts/blacktetra-home.nix
            ];
        }; 
      }; #End homeConfigurations
   }; #End outputs...in 
} #End flake
