{
  description = "Fortydeux NixOS System and Home-manager Flake";

# Flake.nix

  inputs = {  
    stylix.url = "github:danth/stylix";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0"; # Unstable from Flakehub
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2411.714101.tar.gz"; # Feb 5, 2025 from Flakehub
  	# nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Unstable from NixOS
  	home-manager.url = "github:nix-community/home-manager";
  	home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; 
    #Cosmic
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      # inputs.nixpkgs.follows = "nixpkgs";
    };    
    #Hyprland+Plugins
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprgrass = {
       url = "github:horriblename/hyprgrass";
       inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };  
    #MusNix
    musnix.url = "github:musnix/musnix";
    #Transcribee
    transcribee.url = "github:bugbakery/transcribee";
  };
  
  outputs = { self, nixpkgs, home-manager, nixos-hardware, stylix, determinate, nixos-cosmic, hyprland, hyprgrass, hyprland-plugins, musnix, ... }@inputs: 
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
          ];
          specialArgs = { inherit inputs; };
      	};
        #--Killifish host--#
      	killifish-nixos = lib.nixosSystem {
    	  	inherit system;
    	  	modules = [ 
    	  	  ./nixos-config/hosts/killifish/configuration.nix 
          ];
          specialArgs = { inherit inputs; };
      	};
        #--Pufferfish host--#
      	pufferfish-nixos = lib.nixosSystem {
    	  	inherit system;
    	  	modules = [ 
    	  	  ./nixos-config/hosts/pufferfish/configuration.nix 
          ];
          specialArgs = { inherit inputs; };
      	};
        #--Blackfin host--#
      	blackfin-nixos = lib.nixosSystem {
    	  	inherit system;
    	  	modules = [ 
    	  	  ./nixos-config/hosts/blackfin/configuration.nix 
            ];
          specialArgs = { inherit inputs; };
      	};
        #--Blacktetra host--#
        blacktetra-nixos = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./nixos-config/hosts/blacktetra/configuration.nix 
          ];
          specialArgs = { inherit inputs; };
        }; 

      };

      ##--Home-Manager Configuration--##     
      homeConfigurations = {
        "fortydeux@archerfish-nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
    	    modules = [
            ./home-manager/hosts/archerfish-home.nix
          ];
        }; 
        "fortydeux@killifish-nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
    	    modules = [
            ./home-manager/hosts/killifish-home.nix
          ];
        }; 
        "fortydeux@pufferfish-nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
    	    modules = [
            ./home-manager/hosts/pufferfish-home.nix
          ];
        }; 
        "fortydeux@blackfin-nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
    	    modules = [
            ./home-manager/hosts/blackfin-home.nix
          ];
        };
        "fortydeux@blacktetra-nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home-manager/hosts/blacktetra-home.nix
          ];
        }; 
      }; 
   }; 
} 
