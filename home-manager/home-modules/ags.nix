{ config, pkgs, inputs, ... }:

{
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
}
