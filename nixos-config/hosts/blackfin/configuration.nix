{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Configuration.nix - Blackfin
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
    ../../system-modules/audio-prod.nix
    ../../system-modules/screen-recording.nix
    # ../../system-modules/fun-and-games.nix
    # Home-manager
    inputs.home-manager.nixosModules.home-manager
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
  boot.loader.systemd-boot.configurationLimit = 8;

  # Kernel - Turn off when MS-Surface Kernel is enabled
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  musnix.kernel = {
    realtime = true;
    packages = pkgs.linuxPackages_latest_rt;
  };
}
