{ config, pkgs, inputs, ... }: 

{ # window-managers.nix

  programs.uwsm.enable = true;  
  # # Enable Hyprland wm/compositor
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    # xwayland.enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    package = pkgs.hyprland;
    # portalPackage = pkgs.xdg-desktop-portal-hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
    # Ensure the portal services are properly configured
    configPackages = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
  };
  # Oh look, Wayfire wm/compositor snuck in here too - very basic config
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
      wayfire-plugins-extra
    ];
  };

  # ...and River wm/compositor - basic config
  programs.river = {
  	enable = true;
  };

  # Niri compositor
  programs.niri = {
    enable = true;
  };

  # ...and Sway wm/compositor - basic config
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
    package = pkgs.sway;
  };
 
  #Enables Miracle-WM
  programs.wayland.miracle-wm.enable = true;

  # Desktop portal
  # xdg.portal = {
  #     enable = true;
  #     # xdg-desktop-portal backend for Hyprland
  #     # extraPortals =
  #     #   [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
  #   };
  
  # Hint electron apps to use wayland
  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    variables = {
      NIXOS_OZONE_WL = "1";
      XCURSOR_SIZE = "32";
      KDE_SESSION_VERSION = "6";
      KDE_FULL_SESSION = "true";
    };
  };

  programs.dconf.enable = true;

  # Wayland apps 
  environment.systemPackages = with pkgs; [
    # Wayland WM Dependencies & Support packages
    brightnessctl #This program allows you read and control device brightness
    dunst #Lightweight and customizable notification daemon
    # fuzzel #Wayland-native application launcher, similar to rofi's drun mode
    grim #Grab images from a Wayland compositor
    fastfetch #A fast system info script
    hypridle #Hyprland's idle daemon
    hyprlang #The official implementation library for the hypr config language
    hyprlock #Hyprland's simple, yet multi-threaded and GPU-accelerated screen locking utility
    i3bar-river #A port of i3bar for River WM
    i3status-rust #Very resource-friendly and feature-rich replacement for i3status
    kanshi #Dynamic display configuration tool
    kdePackages.qt6ct #Qt6 configuration tool
    mako #A lightweight Wayland notification daemon
    mpvpaper #A video wallpaper program for wlroots based wayland compositors
    # niri #A scrollable-tiling Wayland compositor
    phinger-cursors # Over-engineered cursor theme
    playerctl #Command-line utility and library for controlling media players that implement MPRIS
    libappindicator #A library to allow applications to export a menu into the Unity Menu bar
    libdbusmenu #Library for passing menu structures across DBus
    libnotify #A library that sends desktop notifications to a notification daemon
    lm_sensors #Tools for reading hardware sensors
    meld #Visual diff and merge tool
    networkmanagerapplet #NetworkManager control applet for GNOME
    # nwg-displays #Output management utility for Sway and Hyprland
    # nwg-dock-hyprland #GTK3-based dock for Hyprland
    nwg-look # GTK theme tool
    rofi-wayland #Window switcher, run dialog and dmenu replacement for Wayland
    slurp #Select a region in a Wayland compositor
    swaybg #Wallpaper tool for Wayland compositors
    swayidle #Idle management daemon for Wayland
    swaylock-effects #Screen locker for Wayland
    xfce.thunar #Xfce file manager
    xfce.thunar-archive-plugin #Thunar plugin providing file context menus for archives
    xfce.thunar-volman #Thunar extension for automatic management of removable drives and media
    # pyprland #Python plugins for Hyprland
    waybar #Wayland bar
    # wine-wayland #An Open Source implementation of the Windows API on top of OpenGL and Unix (with experimental Wayland support)
    # wf-recorder # Wayland screen recorder
    wl-clipboard #Command-line copy/paste utilities for Wayland
    wlogout #A wayland based logout menu
    wlopm #Simple client implementing zwlr-output-power-management-v1    
    wlroots #A modular Wayland compositor library
    wlsunset #Day/night gamma adjustments for Wayland
    wlr-randr #An xrandr clone for wlroots compositors
    wofi #A launcher/menu program for wlroots based wayland compositors such as sway
    wvkbd #On-screen keyboard for wlroots
    xfce.xfce4-terminal #Xfce Terminal Emulator
    wdisplays #A graphical application for configuring displays in Wayland compositors
    xdg-utils #A set of command line tools that assist applications with a variety of desktop integration tasks    
    xwayland-satellite #Xwayland outside of your Wayland compositor
    yambar #Another bar option

    # Miracle-WM Packages
    # nwg-dock
    # nwg-drawer
    # nwg-bar
    # nwg-panel
  ];  
     
}
