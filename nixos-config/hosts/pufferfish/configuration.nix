{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  # Configuration.nix - Pufferfish
  imports = [
    ../../system-modules/common-config.nix
    ../../system-modules/extraPackages.nix
    ../../system-modules/display-manager.nix
    ../../system-modules/plasma.nix
    ../../system-modules/window-managers.nix
    ../../system-modules/cosmic-desktop.nix
    ../../system-modules/pcloud.nix
    ../../system-modules/virtualisation.nix
    ../../system-modules/extraFonts.nix
    # ../../system-modules/audio-prod.nix
    # ../../system-modules/fun-and-games.nix
    # Home-manager
    inputs.home-manager.nixosModules.home-manager
    # Device-specific
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  # Be sure to generate your own hardware-configuration.nix before building
  # sudo nixos-generate-config --show-hardware-config > nixos-config/hosts/pufferfish/hardware-configuration.nix

  # Hostname
  networking.hostName = "pufferfish-nixos"; # Define your hostname.

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 8;

  # Kernel - Turn off when MS-Surface Kernel is enabled
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

}
