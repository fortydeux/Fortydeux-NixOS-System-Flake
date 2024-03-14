{ config, pkgs, ... }: 

{ # Hyprland-wm.nix
  
  # Enable Hyprland wm/compositor
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
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
  };

  services.xserver.windowManager.qtile = {
  	enable = true;
  	extraPackages = python3Packages: with python3Packages; [
  	  qtile-extras
  	];
  };
  

  # Hint electron apps to use wayland
  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  # Wayland apps 
  environment.systemPackages = with pkgs; [
    # Wayland WM Dependencies & Support packages
    brightnessctl #This program allows you read and control device brightness
    dunst #Lightweight and customizable notification daemon
    fuzzel #Wayland-native application launcher, similar to rofi’s drun mode
    grim #Grab images from a Wayland compositor
    hypridle #Hyprland's idle daemon
    hyprlang #The official implementation library for the hypr config language
    hyprlock #Hyprland's simple, yet multi-threaded and GPU-accelerated screen locking utility
    i3bar-river #A port of i3bar for River WM
    i3status-rust #Very resource-friendly and feature-rich replacement for i3status
    kanshi #Dynamic display configuration tool
    mako #A lightweight Wayland notification daemon
    mpvpaper #A video wallpaper program for wlroots based wayland compositors
    niri #A scrollable-tiling Wayland compositor
    playerctl #Command-line utility and library for controlling media players that implement MPRIS
    libappindicator #A library to allow applications to export a menu into the Unity Menu bar
    libdbusmenu #Library for passing menu structures across DBus
    libnotify #A library that sends desktop notifications to a notification daemon
    meld #Visual diff and merge tool
    neofetch #A fast, highly customizable system info script
    networkmanagerapplet #NetworkManager control applet for GNOME
    nwg-displays #Output management utility for Sway and Hyprland
    nwg-dock-hyprland #GTK3-based dock for Hyprland
    nwg-look # GTK theme tool
    rofi-wayland #Window switcher, run dialog and dmenu replacement for Wayland
    slurp #Select a region in a Wayland compositor
    swaybg #Wallpaper tool for Wayland compositors
    swayidle #Idle management daemon for Wayland
    swaylock-effects #Screen locker for Wayland
    xfce.thunar #Xfce file manager
    xfce.thunar-archive-plugin #Thunar plugin providing file context menus for archives
    xfce.thunar-volman #Thunar extension for automatic management of removable drives and media
    pyprland #Python plugins for Hyprland
    waybar #Wayland bar
    wine-wayland #An Open Source implementation of the Windows API on top of OpenGL and Unix (with experimental Wayland support)
    wf-recorder # Wayland screen recorder
    wl-clipboard #Command-line copy/paste utilities for Wayland
    wlogout #A wayland based logout menu
    wlroots #A modular Wayland compositor library
    wlsunset #Day/night gamma adjustments for Wayland
    wlr-randr #An xrandr clone for wlroots compositors
    wofi #A launcher/menu program for wlroots based wayland compositors such as sway
    xfce.xfce4-terminal #Xfce Terminal Emulator
    wdisplays #A graphical application for configuring displays in Wayland compositors
    xdg-utils #A set of command line tools that assist applications with a variety of desktop integration tasks    
    yambar #Another bar option
  ];  
     
}
