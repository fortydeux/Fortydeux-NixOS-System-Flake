{config, pkgs, ...}:

{
  ## GTK theming settings
  gtk = {
    enable = true;

    ## Font
    font = {
       name = "Noto Sans";
       package = pkgs.noto-fonts;
       size = 10;
    };
    
    ## GTK Theme
    theme = {
       name = "Dracula";
       package = pkgs.dracula-theme;
    };
        # theme = {
    #   name = "Catppuccin-Macchiato-Compact-Pink-Dark";
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = [ "pink" ];
    #     size = "compact";
    #     tweaks = [ "rimless" "black" ];
    #     variant = "mocha";
    #   };
    # };
    
    ##Icons
    iconTheme = {
      name = "Papirus-Dark-Maia";  # Candy and Tela also look good
      package = pkgs.papirus-maia-icon-theme;
    };
    ## Cursors
    cursorTheme = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors";
      size = 32;
    };
    
    ## GTK 3 Extra
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-key-theme-name    = "Emacs";
      gtk-icon-theme-name   = "Papirus-Dark-Maia";
    };
  };

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  # xdg.configFile = {
  #   "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  #   "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  #   "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  # };
}
