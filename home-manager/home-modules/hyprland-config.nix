{config, pkgs, ... }:

{
  imports = [
  ];

	wayland.windowManager.hyprland = {
        enable = true;
        plugins = [];
        settings = {};
#		extraConfig = ''
#          source = $HOME/.config/hypr/hyprland-config.conf
#		'';
	};
}
