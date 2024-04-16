{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fortydeux";
  home.homeDirectory = "/home/fortydeux";

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

imports = [
    ./hx-gpt.nix
    ];
    
  home.packages = (with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # hello
    anytype #P2P note-taking tool
    appflowy #An open-source alternative to Notion
    decent-sampler #An audio sample player
    discord #Discord social client
    fish #Fish terminal
    gh #Github CLI tool 
    helix #Post modern modal text editor
 #   helix-gpt
    joplin-desktop #An open source note taking and to-do application with synchronisation capabilities
    logseq #Logseq electron desktop client
    libsForQt5.kdenlive #KdenLive Video Editor 
    lan-mouse #Wayland software KVM switch
    media-downloader #Media-downloader desktop client
    mediawriter #USB imaage writer
    musescore #Music notation and composition software
    obs-studio #Screen recorder       
    poppler_utils #Poppler is a PDF rendering library based on the xpdf-3.0 code base. In addition it provides a number of tools that can be installed separately.    
    reaper #Reaper DAW
    signal-desktop #Signal electron desktop client
    simplex-chat-desktop #SimpleX Chat Desktop Client
    spotify #Spotify music client - Requires non-free packages enabled
    telegram-desktop #Telegram desktop client
    ticktick #A powerful to-do & task management app with seamless cloud synchronization across all your devices
    vscode #Open source source code editor developed by Microsoft for Windows, Linux and macOS    
    yt-dlp #Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
    zoom-us #zoom.us video conferencing application
    warp-terminal # Modern rust-based terminal       
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
