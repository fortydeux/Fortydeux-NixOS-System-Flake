{ config, pkgs, ... }:

{ # MS-Surface.nix

  # Enable MS Surface Hardware
  ##Requires nix hardware channel: nixos-hardware https://github.com/NixOS/nixos-hardware/archive/master.tar.gz
  microsoft-surface.ipts.enable = true;
  microsoft-surface.surface-control.enable = true;
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

  ###Surface Laptop Support
  environment.systemPackages = [
    pkgs.libwacom-surface #Libraries, configuration, and diagnostic tools for Wacom tablets running under Linux
  ];
}
