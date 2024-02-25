{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "archerfish-nixos"; # Define your hostname.

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel - Turn off when MS-Surface Kernel is enabled
 # boot.kernelPackages = pkgs.linuxPackages_latest;
}
