{
  description = "Fortydeux NixOS System and Home-manager Flake";

  inputs = {
  	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  	home-manager.url = "github:nix-community/home-manager/master";
  	home-manager.inputs.nixpkgs.follows = "nixpkgs";
  	
  };
  
  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      lib = nixpkgs.lib;
      system = "x84_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {    
      nixosConfigurations = {
      	fortydeux-nixos = lib.nixosSystem {
    	  	inherit system;
    	  	modules = [
    	  	  ./nixos-config/configuration.nix
    	  	];
    	};
      };
      homeConfigurations = {
        fortydeux = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
    	    modules = [./home-manager/home.nix];
        };
      };
   };   
}
