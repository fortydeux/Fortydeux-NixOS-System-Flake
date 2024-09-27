{ config, pkgs, lib, inputs, ... }:

{
  # MS-Surface.nix

  imports = [
	  #MS-Surface-specific modules:
	  inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
    inputs.home-manager.nixosModules.home-manager 
  ];

  # Surface Laptop Support
  environment.systemPackages = [
    pkgs.libwacom-surface
    # Both below are enabled in surface-pro-intel module
    # pkgs.iptsd
    # pkgs.surface-control
  ];

  # Enable better power management
  # services.tlp.enable = true;

  # Enable touchscreen and pen support
  hardware.sensor.iio.enable = true;

  # Uncomment if you need to blacklist webcam and camera-related kernel modules
  boot.blacklistedKernelModules = [ 
  #   "uvcvideo"
  #   "videobuf2_common"
  #   "videobuf2_v4l2"
  #   "videobuf2_memops"
  #   "videobuf2_vmalloc"
    "ipu3_imgu"
  ];
}
