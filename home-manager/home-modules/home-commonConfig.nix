{ config, pkgs, ... }:

{
  imports = [
  ];

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

  home.packages = (with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # hello
    # anytype #P2P note-taking tool
    appflowy #An open-source alternative to Notion
    barrier #Open-source KVM software
    code-cursor #AI-powered code editor built on vscode    
    # cheese # Cheesy camera app
    # decent-sampler #An audio sample player
    # discord #Discord social client
    fish #Fish terminal
    # freetube #An Open Source YouTube app for privacy
    fuzzel # Wayland launcher
    gh #Github CLI tool 
    ghostty #Fast, native, feature-rich terminal emulator pushing modern features
    # helix #Post modern modal text editor
    joplin-desktop #An open source note taking and to-do application with synchronisation capabilities
    # (kdePackages.kdenlive.overrideAttrs (prevAttrs: {
    #   nativeBuildInputs = (prevAttrs.nativeBuildInputs or [ ]) ++ [ makeBinaryWrapper ];
    #   postInstall = (prevAttrs.postInstall or "") + ''
    #     wrapProgram $out/bin/kdenlive --prefix LADSPA_PATH : ${rnnoise-plugin}/lib/ladspa
    #   '';
    # }))
    # kdePackages.kdenlive # Open source video editor based on MLT and KDE frameworks
 #   logseq #Logseq electron desktop client
 #   libsForQt5.kdenlive #KdenLive Video Editor 
    # lan-mouse #Wayland software KVM switch
    # media-downloader #Media-downloader desktop client
    # mediawriter #USB imaage writer
    moc # Terminal music player
    # musescore #Music notation and composition software
    nix-melt # A ranger-like flake.lock viewer
    # obs-studio #Screen recorder       
    patchance # JACK Patchbay GUI
    pdfgrep # Commandline utility to search text in PDF files
    poppler_utils #Poppler is a PDF rendering library based on the xpdf-3.0 code base. In addition it provides a number of tools that can be installed separately.    
    reaper #Reaper DAW
    rustscan #Nmap scanner written in Rust
    # shotcut #Open-source cross-platform video editor
    signal-desktop-bin #Signal electron desktop client
    # simplex-chat-desktop #SimpleX Chat Desktop Client
    # spotify #Spotify music client - Requires non-free packages enabled
    super-productivity # To Do List / Time Tracker with Jira Integration
 #   teams #Microsoft Teams application - not yet available for Linux
    # telegram-desktop #Telegram desktop client
    ticktick #A powerful to-do & task management app with seamless cloud synchronization across all your devices
    tldr # Simplified and community-driven man pages
    tmux #Terminal multiplexer
    vscode #Open source source code editor developed by Microsoft for Windows, Linux and macOS    
    # kdePackages.yakuake #Drop-down terminal emulator based on Konsole technologies
    yt-dlp #Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
    # zoom-us #zoom.us video conferencing application
    warp-terminal # Modern rust-based terminal       
    # waynergy #A synergy client for Wayland compositors
    zed-editor #Modern text editor with AI built in - still in development for Linux
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
  
  # Add custom protocol handlers for VS Code and Cursor
  xdg.desktopEntries = {
    vscode-url-handler = {
      name = "VS Code URL Handler";
      exec = "code --open-url %U";
      icon = "vscode";
      type = "Application";
      noDisplay = true;
      mimeType = [ "x-scheme-handler/vscode" "x-scheme-handler/vscode-insiders" ];
    };
    cursor-url-handler = {
      name = "Cursor URL Handler";
      exec = "cursor --open-url %U";
      icon = "cursor";
      type = "Application";
      noDisplay = true;
      mimeType = [ "x-scheme-handler/cursor" "x-scheme-handler/cursor-insiders" ];
    };
  };
  
  # Ensure XDG desktop portal is properly configured
  systemd.user.services.configure-url-handlers = {
    Unit = {
      Description = "Configure URL handlers for VS Code and Cursor";
      After = "graphical-session-pre.target";
      PartOf = "graphical-session.target";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${./register-url-handlers.sh}";
      RemainAfterExit = true;
    };
  };
  
  programs = {
    fzf.enable = true;
    ghostty = {
      enable = true;
      settings = {
        theme = "stylix";
      };
    };
    helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        # theme = "tokyonight";
        editor = {
          line-number = "relative";
          mouse = true;
        };      
        editor.lsp = {
          display-messages = true;
        };        
        editor.cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };        
        editor.soft-wrap = {
          enable = true;
        };
      };
      languages = {
        language-server = {
          nixd = {
            command = "nixd";
          };
          nil = {
            command = "nil";
          };
        };
        language = [{
          name = "nix";
          language-servers = [ "nixd" "nil" ];
          formatter = {
            command = "nixfmt";
            args = [ "-" ];
          };
          auto-format = false;
        }];       
      };
    };
    nnn = {
      enable = true;
      package = pkgs.nnn.override ({ withNerdIcons = true; });
      extraPackages = with pkgs; [
        mediainfo
        ffmpegthumbnailer
        sxiv
        nsxiv
        tabbed
        file
        zathura
        tree
      ];
      plugins = {
        mappings = {
          #f = "finder";
          #o = "fzopen";
          n = "nuke";
          v = "preview-tabbed";
          p = "preview-tui";
          #s = "-!printf $PWD/$nnn|wl-copy*";
          #d = "";
        };
        src = ./plugins/nnn;
        #src = (pkgs.fetchFromGitHub {
        #  owner = "jarun";
        #  repo = "nnn";
        #  rev = "v4.0";
        #  sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
        #}) + "/plugins";
      };
    };
    yazi = {
      enable = true;
      settings = {
        manager = {
          prepend_keymap = [
            {
              on = "!"; # Might need different keybinding
              run = "shell \"$SHELL\" --block";
              desc = "Open interactive shell";
            }
          ];
        };
      };
    };
    zellij = {
      enable = true;
      settings = {
        # theme = "dracula";
      };
    };
  };

  home.sessionVariables = {
    # NNN_OPENER = "/home/fortydeux/scripts/file-ops/linkhandler.sh";
    # NNN_FCOLORS = "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER";
    NNN_TRASH = 1;
    NNN_FIFO = "/tmp/nnn.fifo";
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
