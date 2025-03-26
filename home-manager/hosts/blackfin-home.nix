{ config, ... }:

{ # blackfin-home.nix

  imports = [
    ../home-modules/home-commonConfig.nix
    ../home-modules/sh-env.nix	
    ../home-modules/dotfiles.nix
    ../home-modules/theming.nix 
    # ../home-modules/emacs-support.nix 
    # ../home-modules/ags.nix
    ../home-modules/hyprland-config.nix
    ../home-modules/hyprland-dualingStudioMonitors.nix
    # ../home-modules/screen-recording.nix
    # ../home-modules/misc-utils.nix
  ];

}
