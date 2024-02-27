{ config, pkgs, ... }:

{ # Configuration.nix - Blackfin
  imports = [
    ../../system-modules/common-config.nix
    ../../system-modules/plasma.nix
    ../../system-modules/hyprland-wm.nix
    ../../system-modules/fun-and-games.nix
    # Device-specific
    ./hardware-configuration.nix
  ];

# Be sure to generate your own hardware-configuration.nix before building 
# sudo nixos-generate-config --show-hardware-config > nixos-config/hosts/blackfin/hardware-configuration.nix

  # Hostname
  networking.hostName = "blackfin-nixos"; # Define your hostname.

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel - Turn off when MS-Surface Kernel is enabled
  boot.kernelPackages = pkgs.linuxPackages_latest;

}
