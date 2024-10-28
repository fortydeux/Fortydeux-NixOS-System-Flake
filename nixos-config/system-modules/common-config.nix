# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{ # Common-config.nix

  # Allow unfree/insecure packages
  nixpkgs.config.allowUnfree = true;
               
  imports = [
    ./networking.nix
    ./security.nix
    ./pcloud.nix
    ./virtualisation.nix
   ];

  ### Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.bash;

  ### System settings
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

  # Enable NumLock at login:
  services.displayManager.sddm.autoNumlock = true;

  # Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Housekeeping
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 20d";
  };
  # system.autoUpgrade.enable = false; 

  # Increase inotify watch limit:
  boot.kernel.sysctl."fs.inotify.max_user_watches" = 1048576;

  # Enable Flatpaks
  services.flatpak.enable = true;

  ### Users
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fortydeux = {
    shell = pkgs.bash;
    isNormalUser = true;
    description = "Fortydeux";
    extraGroups =
      [ "networkmanager" "wheel" "video" "audio" "lp" "surface-control" ];
    packages = with pkgs;
      [
        # User packages may also go into Home.nix if using home-manager
      ];
  };

  ### Packages
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    ## A few of my favorite things that I want on every new install
    alacritty # A cross-platform, GPU-accelerated terminal emulator
    duf # Disk Usage/Free Utility
    fd # a simple, fast and user-friendly alternative to find
    firefox # Firefox browser
    git # Git CLI utility
    gparted # Disk/Partition manager
    htop # Human readable CLI top utility
    kitty # A modern, hackable, featureful, OpenGL based terminal emulator - Default Terminal for Hyprland
    micro # Modern and intuitive terminal-based text editor
    neovim # Vim text editor fork focused on extensibility and agility
    nnn # Small ncurses-based file browser forked from noice
    ranger # File manager with minimalistic curses interface
    ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP

    ## CLI Tools
    appimage-run # Utility for running AppImage format
    feh # Very handy CLI photo/slideshow tool
    ffmpeg # FFmpeg is the leading multimedia framework, able to decode, encode, transcode, mux, demux, stream, filter and play pretty much anything that humans and machines have created. It supports the most obscure ancient formats up to the cutting edge. No matter if they were designed by some standards committee, the community or a corporation.
    jq # A lightweight and flexible command-line JSON processor
    mpv # General-purpose media player, fork of MPlayer and mplayer2
    nix-prefetch-github # Prefetch sources from github
    nmap # Network mapping utility
    pavucontrol # PulseAudio Volume Control
    tlp # Advanced Power Management for Linux
    vim # The most popular clone of the VI editor
    wcalc # A command line calculator

    ## Build tools
    cargo # Downloads your Rust project's dependencies and builds your project
    clang
    # (python311.withPackages
    #   (ps: with ps; [ pycairo pygobject3 ])) # Python3.11 with packages
    wireplumber

    ## GUI Applications
    baobab # Disk Usage Analyzer
    #   blender #3D Creation/Animation/Publishing System
    brave # Brave Browser
    # betterbird # Betterbird is a fine-tuned version of Mozilla Thunderbird, Thunderbird on steroids, if you will - leaving TBird installed bc BT uses same profile, but runs better on Wayland with HIDPI scaling
    chromium # Chromium browser
    kdePackages.discover # KDE and Plasma resources management GUI
    foot # A fast, lightweight and minimalistic Wayland terminal emulator
    fish # Smart and user-friendly command line shell
    gnome-calculator # Gnome GUI calculator
    gnome-calendar # Gnome GUI calendar
    kdePackages.partitionmanager # Manage the disk devices, partitions and file systems on your computer
    kitty-themes # Themes for the kitty terminal emulator
    krita # A free and open source painting application
    lapce # Lightning-fast and Powerful Code Editor written in Rust
    libreoffice-qt # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    # librewolf # A fork of Firefox, focused on privacy, security and freedom
    kdePackages.kate # Plasma text editor
    #   libsForQt5.kdeconnect-kde #KDE Connect provides several features to integrate your phone and your computer
    monitor # Manage processes and monitor system resources
    # pcloud #Previously using nix-env -f channel:nixos-22.11 -iA pcloud instead (seemed to be broken package issue with patchelf https://github.com/NixOS/nixpkgs/issues/226339)
    nautilus # Gnome File Manager
    onlyoffice-bin # Office suite that combines text, spreadsheet and presentation editors allowing to create, view and edit local documents
    tor-browser-bundle-bin # Tor Browser Bundle built by torproject.org
    vscodium # Open source source code editor developed by Microsoft for Windows, Linux and macOS (VS Code without MS branding/telemetry/licensing)
    wezterm # GPU-accelerated cross-platform terminal emulator and multiplexer written by wez and implemented in Rust

    ## Caffeine
    caffeine-ng
    # libsForQt5.plasma-applet-caffeine-plus

    ## Utilities
    foo2zjs    
  ];

  ### Fonts
  fonts.fontconfig.enable = true;
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [ nerdfonts ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  ### Utilities
  programs.nix-ld.enable = true; # Nix-ld ALlows for more normal running of linux binaries on Nix without repackaging or patching with autoPatchelfHook

  ### Services
  # List services that you want to enable:

  #Services - locate:
  services.locate.enable = true;
  services.locate.package = pkgs.plocate;
  services.locate.localuser = null;

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
    graphics.enable = true;
  };

  services.blueman.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
   
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  ### System state version - No touchy!
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
