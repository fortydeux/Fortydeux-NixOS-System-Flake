{config, pkgs, ...}:

{
  # Cursors
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-light";
    size = 32;
  };
  
  # GTK theming settings
  gtk = {
    enable = true;
    # GTK Theme
    theme = {
       name = "Dracula";
       package = pkgs.dracula-theme;
    }; 
    # gtk4.extraConfig = {
    #   gtk-application-prefer-dark-theme = true;
    # };
    # gtk3.extraConfig = {
    #   gtk-application-prefer-dark-theme = true;
    # };
    # gtk2.extraConfig = "
    #   gtk-application-prefer-dark-theme = true
    # ";
  };

  # Qt theming
  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk";
  #   style = {
  #     name = "gtk2";
  #     package = pkgs.libsForQt5.breeze-qt5;
  #   };
  # };
}
