{ config, pkgs, ... }:

{ # Configuration.nix - Archerfish
  imports = [
    ../../system-modules/common-config.nix
    ./hardware-configuration.nix
  ];
    # The most common options you'll want to change for a new host machine reside here
    # For most machines, you'll want to comment out ./ms-surface.nix
    # and change your hostname
    
    # You may also want to enable the latest kernel line
    
    # And also comment out the MS-Surface lines in flake.nix for most machines 
    
    # Be sure to generate your own hardware-configuration.nix before building 
    # sudo nixos-generate-config --show-hardware-config > nixos-config/hosts/archerfish/hardware-configuration.nix
    
    imports = [
      # Remember to also comment out Surface lines in flake.nix if disabling
    	./ms-surface.nix
    ];
  
    # Hostname
    networking.hostName = "archerfish-nixos"; # Define your hostname.
  
    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  
    # Kernel - Turn off when MS-Surface Kernel is enabled
  #  boot.kernelPackages = pkgs.linuxPackages_latest;
}
