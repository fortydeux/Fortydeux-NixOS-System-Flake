{ config, pkgs, ... }:

{
  programs = {
    obs-studio = {
      enable = true;
      plugins = [
        # wlroots-based compositors (Hyprland, Sway, River, Wayfire)
        pkgs.obs-studio-plugins.wlrobs
        
        # Additional plugins
        pkgs.obs-studio-plugins.input-overlay
      ];
    };
  };

  # Additional packages for screen recording
  home.packages = with pkgs; [
    simplescreenrecorder   # Alternative to OBS for basic recording
  ];


}
