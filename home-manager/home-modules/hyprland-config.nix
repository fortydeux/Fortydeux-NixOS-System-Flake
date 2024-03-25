{config, pkgs, ... }:

{
  imports = [
  ];

	wayland.windowManager.hyprland = {
        enable = true;
        plugins = [];
        settings = {};
		extraConfig = ''
          
		'';
	};
}
