{config, pkgs, inputs, ...}:

{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    # image = "${config.users.users.fortydeux.home}/Pictures/wallpapers/AI-Oil-Balloon.png";
    image = pkgs.fetchurl {
        url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
        sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
      };
      polarity = "dark"; 
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
    };
  };

  # imports = [
  #   inputs.stylix.homeManagerModules.stylix
  #   inputs.catppuccin.homeManagerModules.catppuccin
  # ];
 
  # Catppuccin
  # catppuccin = {
  #   enable = true;
  #   flavor = "mocha";
  #   accent = "mauve";
  # };
  # Cursors
  # home.pointerCursor = {
  #   gtk.enable = true;
  #   package = pkgs.phinger-cursors;
  #   name = "phinger-cursors-light";
  #   size = 32;
  # };
  
  # GTK theming settings
  gtk = {
    enable = true;
    #Icon Theme
    iconTheme = {
      package = pkgs.kdePackages.breeze-icons;
      name = "Breeze-Dark";
    };
  #   # Catppuccin
  #   catppuccin = {
  #     enable = true;
  #     flavor = "mocha";
  #     accent = "mauve";
  #     icon.enable = true;
      
  #   };
    # GTK Theme
  #   theme = {
  #      name = "Dracula";
  #      package = pkgs.dracula-theme;
  #   }; 
  #   gtk4.extraConfig = {
  #     gtk-application-prefer-dark-theme = true;
  #   };
  #   gtk3.extraConfig = {
  #     gtk-application-prefer-dark-theme = true;
  #   };
  #   gtk2.extraConfig = "
  #     gtk-application-prefer-dark-theme = true
  #   ";
  };

  # Qt theming
  # qt = {
  #   enable = true;
  #   platformTheme.name = "kvantum";
  #   style = {
  #     name = "kvantum";
  #     catppuccin = {
  #       enable = true;
  #       # apply = true;
  #       flavor = "mocha";
  #       accent = "mauve";
  #     };
  #   };
  # };
}
