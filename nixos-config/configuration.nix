# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,... }:

# Allow packages from unstable with "unstable." as prefix
#let
#  unstable = import <nixos-unstable> {
#    config = config.nixpkgs.config;
#  };
#
#in 
{ 

  # Allow unfree/insecure packages  
  nixpkgs.config = {
    allowUnfree = true;
  };
  
  imports =
    [ # Include the results of the hardware scan.
     # <nixos-hardware/microsoft/surface/common>
      ./hardware-configuration.nix
    ];

  # Enable MS Surface Hardware 
  ##Requires nix hardware channel: nixos-hardware https://github.com/NixOS/nixos-hardware/archive/master.tar.gz
#  microsoft-surface.ipts.enable = true;
#  microsoft-surface.surface-control.enable = true;
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
    
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel 
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Security
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;
  security.doas.enable = false;

  networking.hostName = "blackfin-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  
  #Flatpaks
  services.flatpak.enable = true;
  
  # Enable the X11 windowing system...and... 
  #KDE/Plasma
  services.xserver = {
    enable = true;
    # Enable KDE, Plasma
    displayManager = {
      sddm.enable = true;
      #sddm.theme = "${import /home/fortydeux/.config/home-manager/sddm-theme.nix { inherit pkgs; }}";
    };
    desktopManager.plasma5.enable = true;
  };
    
  #Services - Syncthing
  services.syncthing = {
        enable = true;
        user = "fortydeux";
        dataDir = "/home/fortydeux";    # Default folder for new synced folders
        configDir = "/home/fortydeux/.config/syncthing";   # Folder for Syncthing's settings and keys
  };

  # Services Emacs
  services.emacs.enable = true;

  # Services - Mullvad VPN
  services.mullvad-vpn.enable = true;

  #Services - clamav updater: freshclam
  services.clamav.updater.enable = true;

  #Services - Virtualization
  #virtualisation.virtualbox.host.enable = true;
  virtualisation.libvirtd.enable = true;
  
  #Services - locate:
  services.locate.enable = true;
  services.locate.package = pkgs.plocate;
  services.locate.localuser = null;
  
  # Services - swaylock (pam).
  security.pam.services.swaylock = {};

  xdg.portal = {
    enable = true;
    # xdg-desktop-portal backend for Hyprland
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
  };
  
  # Enable Hyprland window manager.
  programs.hyprland = {
    enable = true;
  #  xwayland.hidpi = true; #deprecated
    xwayland.enable = true;
  };
  environment = {
    # Hint electron apps to use wayland
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
    
   # Greetd - enable if disabling other login managers 
#  services.greetd = {
#    enable = true;
#  #  settings = {
#  #    default_session = {
#  #      command = "${pkgs.hyprland}/bin/Hyprland --config ${hyprConfig}";
#  #    };
#  #  };
#    settings = rec {
#      initial_session = {
#        command = "${pkgs.hyprland}/bin/Hyprland";
#        user = "fortydeux";
#      };
#      default_session = initial_session;
#    };
#  };
    
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable Hardware. Components
  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = false;
    opengl.enable = true;
  };

  services.blueman.enable = true;
  services.tailscale.enable = true; 

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable Steam - Steam games distribution
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fortydeux = {
    isNormalUser = true;
    description = "Fortydeux";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" "surface-control"];
    packages = with pkgs; [
        gh #Github CLI tool 
        git-credential-manager #Git credential manager
        dotnet-runtime_7 # .NET runtime - required for git-credential-manager
        discord #Discord social client
    #    pcloud 
    #    googleearth-pro #Google Earth Pro - requires insecure packages enabled - install with flatpak instead thus containered
        logseq #Logseq electron desktop client
        reaper #Reaper DAW
        signal-desktop #Signal electron desktop client
        telegram-desktop #Telegram desktop client
        simplex-chat-desktop #SimpleX Chat Desktop Client
    #    todoist-electron #Todoist electron desktop client
        media-downloader #Media-downloader desktop client
        libsForQt5.kdenlive #KdenLive Video Editor 
        anytype #P2P note-taking tool
        appflowy #An open-source alternative to Notion
        mediawriter
        mullvad-vpn
        ticktick #A powerful to-do & task management app with seamless cloud synchronization across all your devices
        obs-studio #Screen recorder
        spotify #Spotify music client - Requires non-free packages enabled
        yt-dlp #Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
        joplin-desktop #An open source note taking and to-do application with synchronisation capabilities
        ffmpeg #FFmpeg is the leading multimedia framework, able to decode, encode, transcode, mux, demux, stream, filter and play pretty much anything that humans and machines have created. It supports the most obscure ancient formats up to the cutting edge. No matter if they were designed by some standards committee, the community or a corporation.
        
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget  
  environment.systemPackages = with pkgs; [
    ### Nix-specific
    # home-manager

    ## Photo / Slideshow tools
    feh

    ###CLI Tools
    appimage-run #Utility for running AppImage format
    clamav #Virus scanner
    duf #Disk Usage/Free Utility
    findutils #Basic directory searching utilities 
    git #Git CLI utility
    emacs #GNU extensible text editor
    htop #Human readable CLI top utility
    micro #Modern and intuitive terminal-based text editor
    mpv #General-purpose media player, fork of MPlayer and mplayer2
    nnn #Small ncurses-based file browser forked from noice
    nix-prefetch-github #Prefetch sources from github
    pavucontrol #PulseAudio Volume Control
    qemu #Virtual machine client CLI
    ranger #File manager with minimalistic curses interface
    ripgrep #Utility that combines the usability of The Silver Searcher with the raw speed of grep
    tlp #Advanced Power Management for Linux
    vim #The most popular clone of the VI editor
    wcalc #A command line calculator
    wget #Tool for retrieving files using HTTP, HTTPS, and FTP
    # optional emacs dependencies
    coreutils # basic GNU utilities
    fd #a simple, fast and user-friendly alternative to find
    clang
    ###Build tools
    cargo #Downloads your Rust project's dependencies and builds your project
    (python311.withPackages(ps: with ps; [ pycairo pygobject3])) #Python3.11 with packages

    ###Candy - not necessary
    cava #Console-based Audio Visualizer for Alsa
    cbonsai #Grow bonsai trees in your terminal
    cmatrix #Simulates the falling characters theme from The Matrix movie
    cool-retro-term #erminal emulator which mimics the old cathode display
    distrobox
    hollywood #Fill your console with Hollywood melodrama technobabble
    nms #A command line tool that recreates the famous data decryption effect seen in the 1992 movie Sneakers.
    pipes #Animated pipes terminal screensaver
    tty-clock #Digital clock in ncurses
    vitetris #Terminal-based Tetris clone by Victor Nilsson

    ###GUI Applications
    alacritty #A cross-platform, GPU-accelerated terminal emulator
    baobab #Disk Usage Analyzer
    blender #3D Creation/Animation/Publishing System
    gnome.gnome-boxes #Virtual machine gui client
    brave #Brave Browser
    betterbird #Betterbird is a fine-tuned version of Mozilla Thunderbird, Thunderbird on steroids, if you will - leaving TBird installed bc BT uses same profile, but runs better on Wayland with HIDPI scaling
    chromium #Chromium browser
    element-desktop #A feature-rich client for Matrix.org
    emote #Modern emoji picker for Linux
    foot #A fast, lightweight and minimalistic Wayland terminal emulator
    fish #Smart and user-friendly command line shell
    firefox #Firefox browser
    geany #Small and lightweight IDE
    gnome.gnome-calculator #Gnome GUI calculator
    gnome.gnome-calendar #Gnome GUI calendar  
    gparted #Disk/Partition manager
    libsForQt5.kate #Plasma text editor
 #   libsForQt5.kdeconnect-kde #KDE Connect provides several features to integrate your phone and your computer
    kitty #A modern, hackable, featureful, OpenGL based terminal emulator - Default Terminal for Hyprland
    kitty-themes #Themes for the kitty terminal emulator
    krita #A free and open source painting application
    lapce #Lightning-fast and Powerful Code Editor written in Rust
    libreoffice-qt #Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    librewolf #A fork of Firefox, focused on privacy, security and freedom
    lutris #Open Source gaming platform for GNU/Linux
    monitor #Manage processes and monitor system resources
    gnome.nautilus #Gnome File Manager
    onlyoffice-bin #Office suite that combines text, spreadsheet and presentation editors allowing to create, view and edit local documents
 #   thunderbird #Mozilla Thunderbird, a full-featured email client 
    tor-browser-bundle-bin #Tor Browser Bundle built by torproject.org
    vscodium #Open source source code editor developed by Microsoft for Windows, Linux and macOS (VS Code without MS branding/telemetry/licensing)
    wezterm #GPU-accelerated cross-platform terminal emulator and multiplexer written by @wez and implemented in Rust
    pcloud #Previously using nix-env -f channel:nixos-22.11 -iA pcloud instead (seemed to be broken package issue with patchelf https://github.com/NixOS/nixpkgs/issues/226339)

    ###Window Managers
  #  hyprland-protocols #Wayland protocol extensions for Hyprland
  #  hyprland-share-picker 
    wayfire #Compiz-based 3D Wayland compositor
    wdisplays #A graphical application for configuring displays in Wayland compositors
    wayfirePlugins.wcm #Wayfire Config Manager
    xdg-utils #A set of command line tools that assist applications with a variety of desktop integration tasks
  #  wf-config #Library for managing configuration files, written for Wayfire

    ###WM Dependencies & Support packages
  #  blueberry #Bluetooth configuration tool
  #  bluetuith #TUI-based bluetooth connection manager
  #  blueman #GTK-based Bluetooth configuration tool
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
    #trayer #A lightweight GTK2-based systray for UNIX desktop
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

    ###Icons, Themes, and Theme tools
#    adapta-gtk-theme #Adapta GTK Theme
#    at-spi2-atk #Assistive Technology Service Provider Interface protocol definitions and daemon for D-Bus
#    arc-theme #Flat theme with transparent elements for GTK 3, GTK 2 and Gnome Shell
#    ayu-theme-gtk #Ayu GTK Theme
#    breath-theme #Breath Theme - Plasma
#    catppuccin-gtk #Catppuccin GTK Theme
#    catppuccin-kvantum #Catppuccin Kvantum Theme
#    dconf #dconf is a low-level configuration system. Its main purpose is to provide a backend to GSettings on platforms that don't already have configuration storage systems.
#    glib #C library of programming buildings blocks
#    gsettings-desktop-schemas #Collection of GSettings schemas for settings shared by various components of a desktop
#    gnome.gucharmap #GNOME Character Map, based on the Unicode Character Database
#    pop-gtk-theme #Pop GTK Theme
#    libsForQt5.qt5.qtquickcontrols2 #A cross-platform application framework for C++
#    libsForQt5.qt5.qtgraphicaleffects #A cross-platform application framework for C++
#    theme-obsidian2 #Gnome theme based upon Adwaita-Maia dark skin
#    arc-icon-theme #Arc Icon Theme
#    papirus-icon-theme #Papirus Icon Theme
#    luna-icons #Icon pack based on marwaita and papirus icons
#    material-design-icons #Material Design Icons
#    gnome.adwaita-icon-theme #Adwaita Icon Theme
#
    ### AGS dependencies
    swww
    sassc  

    ###Surface Laptop Support
    libwacom-surface #Libraries, configuration, and diagnostic tools for Wacom tablets running under Linux
    glm #OpenGL Mathematics library for C++ - needed for hyprgrass plugin and touchscreen gesture support for hyprland
    jq #A lightweight and flexible command-line JSON processor - dependency for installing hyprload

    ## Misc that I'm too lazy to categorize
    wireguard-tools
    openvpn
    caffeine-ng
    libsForQt5.plasma-applet-caffeine-plus
   ]; 
   
  ### Fonts
  fonts.fontconfig.enable = true;
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
# 	 dejavu_fonts
# 	 font-awesome
# 	 inter
#  	 jetbrains-mono
 	 nerdfonts
#  	 borg-sans-mono
# 	 cantarell-fonts
# 	 hack-font
# 	 inconsolata-nerdfont
# 	 iosevka
# 	 liberation_ttf
# 	 noto-fonts
# 	 roboto
# 	 tamsyn
# 	 ttf_bitstream_vera
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  programs.kdeconnect.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
