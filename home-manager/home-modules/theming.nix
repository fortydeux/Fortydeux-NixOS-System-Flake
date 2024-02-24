{config, pkgs, ...}:

{
  ## GTK theming settings
  gtk = {
    enable = true;
    font.name = "Noto Sans";
    font.package = pkgs.noto-fonts;
    font.size = 10;
    theme.name = "Dracula";
    theme.package = pkgs.dracula-theme;
    iconTheme.name = "Papirus-Dark-Maia";  # Candy and Tela also look good
    iconTheme.package = pkgs.papirus-maia-icon-theme;
    cursorTheme.package = pkgs.phinger-cursors;
    cursorTheme.name = "phinger-cursors";
    cursorTheme.size = 32;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-key-theme-name    = "Emacs";
      gtk-icon-theme-name   = "Papirus-Dark-Maia";
    };
  };
}
