{ config, pkgs, ... }: 

{ # Hyprland-wm.nix
  
  # Enable Hyprland window manager.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment = {
    # Hint electron apps to use wayland
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
  	## Oh look, Wayfire-wm snuck in here, too... 
    wayfire #Compiz-based 3D Wayland compositor
    wdisplays #A graphical application for configuring displays in Wayland compositors
    wayfirePlugins.wcm #Wayfire Config Manager
    xdg-utils #A set of command line tools that assist applications with a variety of desktop integration tasks

    ###WM Dependencies & Support packages
    brightnessctl #This program allows you read and control device brightness
    dunst #Lightweight and customizable notification daemon
    fuzzel #Wayland-native application launcher, similar to rofi’s drun mode
    grim #Grab images from a Wayland compositor
    mako #A lightweight Wayland notification daemon
    mpvpaper #A video wallpaper program for wlroots based wayland compositors
    playerctl #Command-line utility and library for controlling media players that implement MPRIS
    libappindicator #A library to allow applications to export a menu into the Unity Menu bar
    libdbusmenu #Library for passing menu structures across DBus
    libnotify #A library that sends desktop notifications to a notification daemon
    meld #Visual diff and merge tool
    neofetch #A fast, highly customizable system info script
    networkmanagerapplet #NetworkManager control applet for GNOME
    nwg-displays #Output management utility for Sway and Hyprland
    nwg-dock-hyprland #GTK3-based dock for Hyprland
    rofi-wayland #Window switcher, run dialog and dmenu replacement for Wayland
    slurp #Select a region in a Wayland compositor
    swaybg #Wallpaper tool for Wayland compositors
    swayidle #Idle management daemon for Wayland
    swaylock-effects #Screen locker for Wayland
    xfce.thunar #Xfce file manager
    xfce.thunar-archive-plugin #Thunar plugin providing file context menus for archives
    xfce.thunar-volman #Thunar extension for automatic management of removable drives and media
    pyprland
    waybar
    wine-wayland #An Open Source implementation of the Windows API on top of OpenGL and Unix (with experimental Wayland support)
    wl-clipboard #Command-line copy/paste utilities for Wayland
    wlogout #A wayland based logout menu
    wlroots #A modular Wayland compositor library
    wlsunset #Day/night gamma adjustments for Wayland
    wlr-randr #An xrandr clone for wlroots compositors
    wofi #A launcher/menu program for wlroots based wayland compositors such as sway
    xfce.xfce4-terminal #Xfce Terminal Emulator

  ];  
     
}
