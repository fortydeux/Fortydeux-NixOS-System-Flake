{config, pkgs, inputs, ... }:

# let
#   system = pkgs.hostPlatform.system;
# in
{
  imports = [
  ];

	wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.default;
        systemd.variables = ["--all"];
        plugins = [
          # Hyprexpo plugin
          inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo   
          # pkgs.hyprlandPlugins.hyprexpo
          # "${pkgs.hyprexpo}/lib/libhyprexpo.so"       
          # Hyprgrass plugin
          inputs.hyprgrass.packages.${pkgs.system}.hyprgrass
          # "${hyprgrass}/lib/hyprgrass.so"       
          # Hyprscroller plugin
          pkgs.hyprlandPlugins.hyprscroller       
          # "${hyprscroller}/lib/hyprscroller.so"       
          # Hyprscpace plugin
          inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
          # "${hyprspace}/lib/hyprspace.so"       
        ];
        settings = {
           plugin = {
                  hyprexpo = {
                    columns = 3;
                    gap_size = 5;
                    bg_col = "rgb(111111)";
                    workspace_method = "first current"; # [center/first] [workspace] e.g. first 1 or center m+1
                    enable_gesture = true; # laptop touchpad, 4 fingers
                    gesture_distance = 300; # how far is the "max"
                    gesture_positive = true; # positive = swipe down. Negative = swipe up.
                  };
                };         
        };
		extraConfig = ''
      bind = SUPER, grave, hyprexpo:expo, toggle
    '';
	};
  xdg.portal = {
    enable = true;
    extraPortals = [config.wayland.windowManager.hyprland.package];
    configPackages = [config.wayland.windowManager.hyprland.package];
  };
}
