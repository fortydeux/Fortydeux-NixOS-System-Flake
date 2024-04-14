{
  description = "Fortydeux NixOS System and Home-manager Flake";

# Flake.nix

  inputs = {
  	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  	home-manager.url = "github:nix-community/home-manager/master";
  	home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; 
    
    # Add ags
    ags.url = "github:Aylur/ags"; 	
    # Add helix-gpt
    helix-gpt.url = "github:SilverCoder/helix-gpt/main";
    };
  
  outputs = { self, nixpkgs, home-manager, helix-gpt, ... }@inputs: 
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
    	  	  #MS-Surface-specific module:
     	  	  inputs.nixos-hardware.nixosModules.microsoft-surface-common 
            ];
    	};
        #--Pufferfish host--#
      	pufferfish-nixos = lib.nixosSystem {
    	  	inherit system;
    	  	modules = [ 
    	  	  ./nixos-config/hosts/pufferfish/configuration.nix 
             ];
    	};
        #--Blackfin host--#
      	blackfin-nixos = lib.nixosSystem {
    	  	inherit system;
    	  	modules = [ 
    	  	  ./nixos-config/hosts/blackfin/configuration.nix 
             ];
    	};
      };

     ##--Helix-GPT devShell--##
      devShells.default = pkgs.mkShell {
        packages = [ helix-gpt.packages.default ];
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
      }; #End homeConfigurations
   }; #End outputs...in 
} #End flake
