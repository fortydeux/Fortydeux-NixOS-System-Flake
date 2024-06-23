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

  # Blacklist webcam and camera-related kernel modules
  boot.blacklistedKernelModules = [ 
    # "uvcvideo"  # Common USB webcam driver
    # "videobuf2_common"
    # "videobuf2_v4l2"
    # "videobuf2_memops"
    # "videobuf2_vmalloc"
    "ipu3_imgu"  # Specifically for Intel IPU3 cameras
  ]; 
}
