{ config, pkgs, inputs, ... }:

{ # Ags.nix

  ## AGS import and settings
  imports = [ inputs.ags.homeManagerModules.default ];
  programs.ags = {
  	enable = true;
  	#configDir = ./dotfiles/ags;
  	extraPackages = with pkgs; [
  		gtksourceview
  		webkitgtk
  		accountsservice
  	];
  };

  home.packages = (with pkgs; [
    ## AGS dependencies
    swww
    sassc  
  ]);
}
