{ config, pkgs, ... }:

{ # Plasma.nix

  #Enable SDDM Display manager
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
  };
  # Enable KDE Plasma
  services.desktopManager.plasma6.enable = true;
 

}
