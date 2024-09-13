{config, pkgs, inputs, ... }:

let
  system = pkgs.hostPlatform.system;
in
{
  imports = [
  ];

	wayland.windowManager.hyprland = {
        enable = true;
        systemd.variables = ["--all"];
        plugins = [
          # Hyprexpo plugin
          inputs.hyprland-plugins.packages.${system}.hyprexpo   
          # "${pkgs.hyprexpo}/lib/libhyprexpo.so"       
          # Hyprgrass plugin
          inputs.hyprgrass.packages.${system}.hyprgrass
          # "${hyprgrass}/lib/hyprgrass.so"       
          # Hyprscroller plugin
          pkgs.hyprlandPlugins.hyprscroller       
          # "${hyprscroller}/lib/hyprscroller.so"       
          # Hyprscpace plugin
          inputs.Hyprspace.packages.${system}.Hyprspace
          # "${hyprspace}/lib/hyprspace.so"       
        ];
        settings = {};
		extraConfig = ''
          
		'';
	};
}
