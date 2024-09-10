{ config, pkgs, ... }:

{ # Plasma.nix

  # Enable KDE Plasma
  services.desktopManager.plasma6.enable = true;

  # Enable Xorg session
  services.xserver.enable = true;

  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   systemsettings
  # ];
  
  environment.systemPackages = with pkgs; [
    xorg.xinit
  ];
}
