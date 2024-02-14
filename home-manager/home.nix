{ config, pkgs, lib, inputs, ... }:
let
  #gruvboxPlus = import ./gruvbox-plus.nix { inherit pkgs; };
  
  # Path to your dotfiles directory.
  dotfilesDir = ./hyprland-dotfiles;

  # Generate an attribute set where keys are dotfile names and values are their respective paths.
  dotfiles = builtins.attrFromList (map (f: [f "${dotfilesDir}/${f}"]) (builtins.readDir dotfilesDir));
in
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
  home.stateVersion = "22.11"; # Please read the comment before changing.

  imports = [ inputs.ags.homeManagerModules.default ];

    programs.ags = {
  	enable = true; 
  	#configDir = ./dotfiles/ags;
  	extraPackages = with pkgs; [
  		gtksourceview
  		webkitgtk
  		accountsservice
  	];
  };

  ## Enable Qt
  #qt.enable = true;
  #qt.platformTheme = "gtk";
  #qt.style.name = "adwaita-dark";
  #qt.style.package = pkgs.adwaita-qt;

  gtk.enable = true;
  gtk.font.name = "Noto Sans";
  gtk.font.package = pkgs.noto-fonts;
  gtk.font.size = 10;
  gtk.theme.name = "Dracula";
  gtk.theme.package = pkgs.dracula-theme;
  gtk.iconTheme.name = "Papirus-Dark-Maia";  # Candy and Tela also look good
  gtk.iconTheme.package = pkgs.papirus-maia-icon-theme;
  gtk.cursorTheme.package = pkgs.phinger-cursors;
  gtk.cursorTheme.name = "phinger-cursors";
  gtk.cursorTheme.size = 32; 
  gtk.gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = true;
    gtk-key-theme-name    = "Emacs";
    gtk-icon-theme-name   = "Papirus-Dark-Maia";
    # removed cursor theme name
    # gtk-cursor-theme-size = 24;
    # gtk-toolbar-style = GTK_TOOLBAR_BOTH;
    # gtk-toolbar-icon-size = "small";
    # gtk-toolbar-font-size = 14;
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-key-theme = "Emacs";
      #cursor-theme = "Capitaine Cursors";
    };
  };
  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];



  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.cowsay

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
  ];
#  home.packages = with inputs; [
#  	pcloud.packages.x86_64-linux.pcloud
#  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/hypr".source = dotfiles/hypr;
    ".config/wayfire.ini".source = dotfiles/wayfire/wayfire.ini;
    ".config/wf-shell.ini".source = dotfiles/wayfire/wf-shell.ini;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fortydeux/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
