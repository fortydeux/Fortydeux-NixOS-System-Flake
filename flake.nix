{
  description = "Fortydeux NixOS System and Home-manager Flake";

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
  #  	  	  inputs.nixos-hardware.nixosModules.microsoft-surface-common ##Comment for other hardware
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
