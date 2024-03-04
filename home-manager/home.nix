{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fortydeux";
  home.homeDirectory = "/home/fortydeux";

  imports = [
    ./home-modules/sh-env.nix	
    ./home-modules/ags.nix
    ./home-modules/theming.nix 
    ./home-modules/emacs-support.nix 
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;

  home.packages = (with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # hello
    gh #Github CLI tool 
    discord #Discord social client
    logseq #Logseq electron desktop client
    reaper #Reaper DAW
    signal-desktop #Signal electron desktop client
    telegram-desktop #Telegram desktop client
    simplex-chat-desktop #SimpleX Chat Desktop Client
    media-downloader #Media-downloader desktop client
    libsForQt5.kdenlive #KdenLive Video Editor 
    anytype #P2P note-taking tool
    appflowy #An open-source alternative to Notion
    mediawriter
    ticktick #A powerful to-do & task management app with seamless cloud synchronization across all your devices
    obs-studio #Screen recorder
    spotify #Spotify music client - Requires non-free packages enabled
    yt-dlp #Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
    joplin-desktop #An open source note taking and to-do application with synchronisation capabilities
#Not yet available on Linux through nixpkgs    warp-terminal # Modern rust-based terminal       
  ]);
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/dunst" = {
    	source = dotfiles/dunst;
        recursive = true;
    };

    ".config/hypr" = {
    	source = dotfiles/hypr;
        recursive = true;
    };
    ".config/kitty" = {
    	source = dotfiles/kitty;
    	recursive = true;
    };
    ".config/mako" = {
    	source = dotfiles/mako;
    	recursive = true;
    };
    ".config/micro" = {
    	source = dotfiles/micro;
    	recursive = true;
    }; 
    ".config/nvim" = {
    	source = dotfiles/nvim;
    	recursive = true;
    }; 
    ".config/foot" = {
    	source = dotfiles/foot;
    	recursive = true;
    };
    ".config/ranger" = {
    	source = dotfiles/ranger;
    	recursive = true;
    }; 
    ".config/wayfire.ini" = {
    	source = dotfiles/wayfire/wayfire.ini;
    };
    ".config/wf-shell.ini" = {
    	source = dotfiles/wayfire/wf-shell.ini;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fortydeux/etc/profile.d/hm-session-vars.sh
  #
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
