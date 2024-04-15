{ config, pkgs, ... }:

{ # Plasma.nix

  #Enable SDDM Display manager
  services.displayManager = {
    enable = true;
    sddm.enable = true;
    sddm.wayland.enable = true;
  };
  # Enable KDE Plasma
  services.desktopManager.plasma6.enable = true;
 

}
