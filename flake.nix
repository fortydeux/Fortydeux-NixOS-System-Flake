{
  description = "Fortydeux NixOS System and Home-manager Flake";

# Flake.nix

  inputs = {
  	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  	home-manager.url = "github:nix-community/home-manager/master";
  	home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; 
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };  
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprgrass = {
       url = "github:horriblename/hyprgrass";
       inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };  
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
      inputs.hyprland.follows = "hyprland";
    };

  };
  
  outputs = { self, nixpkgs, home-manager, nixos-hardware, nixos-cosmic, hyprland, hyprgrass, Hyprspace, ... }@inputs: 
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
          #   (import ./nixos-config/system-modules/cosmic-desktop.nix {
          #     inherit inputs;
          #   })
    	  	  #MS-Surface-specific modules:
     	  	  nixos-hardware.nixosModules.microsoft-surface-pro-intel
            home-manager.nixosModules.home-manager
            {
              xdg.portal.wlr.enable = lib.mkForce true; # Adjust based on your preference
            }
            ];
    	};
        #--Pufferfish host--#
      	pufferfish-nixos = lib.nixosSystem {
    	  	inherit system;
    	  	modules = [ 
    	  	  ./nixos-config/hosts/pufferfish/configuration.nix 
          #   (import ./nixos-config/system-modules/cosmic-desktop.nix {
          #     inherit inputs;
          #   })
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-pc-laptop
            nixos-hardware.nixosModules.common-pc-laptop-ssd
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
          #   (import ./nixos-config/system-modules/cosmic-desktop.nix {
          #     inherit inputs;
          #   })
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
            # (import ./nixos-config/system-modules/cosmic-desktop.nix {
            #   inherit inputs;
            # })
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
