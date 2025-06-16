{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    # image = ../dotfiles/wallpapers/balloon-wp.jpg;
    # image = pkgs.fetchurl {
    #   url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
    #   sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
    # };
    polarity = "dark"; 
    base16Scheme = "${pkgs.base16-schemes}/share/themes/valua.yaml";
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 32;
    };
    # targets = {
    # };
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    gnome-icon-theme
    hicolor-icon-theme
    hicolor-icon-theme
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
  ];

  environment.sessionVariables = lib.mkForce {
    QT_QPA_PLATFORMTHEME = "kde";
  };
}
