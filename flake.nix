{
  description = "Fortydeux NixOS System and Home-manager Flake";

# Flake.nix

# For most machines, comment out the microsoft-surface hardware line/s 

  inputs = {
  	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  	home-manager.url = "github:nix-community/home-manager/master";
  	home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; ##Comment for other hardware

    # Add ags
    ags.url = "github:Aylur/ags"; 	
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {    
      nixosConfigurations = {
      	fortydeux-nixos = lib.nixosSystem {
    	  	inherit system;
    	  	modules = [ 
    	  	  ./nixos-config/configuration.nix 
 # MS-Surface device-specific hardware package - comment out for most host machines
    	  	  inputs.nixos-hardware.nixosModules.microsoft-surface-common ##Comment for other hardware
            ];
    	};
      };
      homeConfigurations = {
        fortydeux = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Pass inputs as extraSpecialArgs
            extraSpecialArgs = { inherit inputs; };

            # Import home.nix
    	    modules = [
              ./home-manager/home.nix
            ];
        };
      };
   };   
}
