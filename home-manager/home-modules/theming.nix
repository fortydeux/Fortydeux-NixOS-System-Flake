{config, lib, pkgs, inputs, ...}:

{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    image = ../dotfiles/wallpapers/balloon-wp.jpg; 
    # image = pkgs.fetchurl {
    #   url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
    #   sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
    # };
    polarity = "dark"; 
    base16Scheme = "${pkgs.base16-schemes}/share/themes/colors.yaml";
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
    };
  };

  # GTK theming settings
  gtk = {
    enable = true;
    #Icon Theme
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  # Qt theming
   qt = {
      enable = true;
      # platformTheme.package = with pkgs.kdePackages; [
      #     plasma-integration
      #     # I don't remember why I put this is here, maybe it fixes the theme of the system setttings
      #     systemsettings
      # ];
      style = {
          package = pkgs.kdePackages.breeze;
          # name = "Breeze";
      };
  };
  systemd.user.sessionVariables = lib.mkForce { QT_QPA_PLATFORMTHEME = "kde"; };
}
