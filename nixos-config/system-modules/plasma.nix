{ config, pkgs, ... }:

{ # Plasma.nix

  # Enable KDE Plasma
  services.desktopManager.plasma6.enable = true;

  # Enable Xorg session
  # services.xserver.enable = true;
 
  # environment.systemPackages = with pkgs; [
  #   xorg.xinit
  # ];
}
