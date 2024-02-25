{ config, pkgs, ... }:

{ # Device-specific.nix

  imports = [
    # Remember to also comment out Surface lines in flake.nix if disabling
#  	./ms-surface.nix
  ];

  # Hostname
  networking.hostName = "blackfin-nixos"; # Define your hostname.

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel - Turn off when MS-Surface Kernel is enabled
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
