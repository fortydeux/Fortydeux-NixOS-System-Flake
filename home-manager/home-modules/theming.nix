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
  };
}
