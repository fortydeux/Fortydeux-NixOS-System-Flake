{
  description = "Fortydeux NixOS System and Home-manager Flake";

  inputs = {
  	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  
  outputs = { self, nixpkgs, ... }: 
    let
      lib = nixpkgs.lib;
    in
    {
    
      nixosConfigurations = {
      	archerfish-nixos = lib.nixosSystem {
    	  	system = "x86_64-linux";
    	  	modules = [
    	  	  ./nixos-config/configuration.nix
    	  	];
    	};
     };

  };
}
