{config, pkgs, ...}:

{
  # Cursors
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-light";
    size = 32;
  };
  # # QT theming settings
  # qt = {
  #   enable = true;
  #   platformTheme.name = "kde";
  # };
  # GTK theming settings
  gtk = {
    enable = true;

  #   # Font
  #   font = {
  #      name = "Noto Sans";
  #      package = pkgs.noto-fonts;
  #      size = 10;
  #   };
    
    # GTK Theme
    theme = {
       name = "Dracula";
       package = pkgs.dracula-theme;
    };
   
  #   #Icons
  #   iconTheme = {
  #     name = "Papirus-Dark-Maia";  # Candy and Tela also look good
  #     package = pkgs.papirus-maia-icon-theme;
  #   };
  #   # Cursors
  #   # cursorTheme = {
  #   #   package = pkgs.phinger-cursors;
  #   #   name = "phinger-cursors";
  #   #   size = 32;
  #   # };
    
  #   # GTK 3 Extra
  #   gtk3.extraConfig = {
  #     gtk-application-prefer-dark-theme = true;
  #     gtk-key-theme-name    = "Emacs";
  #     gtk-icon-theme-name   = "Papirus-Dark-Maia";
  #   };
  };

}
