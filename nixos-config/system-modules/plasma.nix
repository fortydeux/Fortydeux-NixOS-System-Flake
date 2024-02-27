{ config, pkgs, ... }:

{ # Plasma.nix

  services.xserver.displayManager.sddm.enable = true;

  # Enable the X11 windowing system...and...
  # KDE/Plasma
  services.xserver = {
    enable = true;
    # Enable KDE, Plasma
    desktopManager.plasma5.enable = true;
  };

}
