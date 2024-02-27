{ config, lib, pkgs, ... }:

{ # Configuration.nix - Pufferfish
  imports = [
    ../system-modules/common-config.nix
    ./hardware-configuration.nix
  ];

# Be sure to generate your own hardware-configuration.nix before building 
# sudo nixos-generate-config --show-hardware-config > nixos-config/hosts/pufferfish/hardware-configuration.nix

  # Hostname
  networking.hostName = "pufferfish-nixos"; # Define your hostname.

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel - Turn off when MS-Surface Kernel is enabled
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
}
