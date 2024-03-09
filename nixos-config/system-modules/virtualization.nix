{ config, pkgs, ... }:

{ # Virtualization.nix

  #Services - Virtualization
  #virtualisation.virtualbox.host.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.waydroid.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    qemu # Virtual machine client CLI
    gnome.gnome-boxes # Virtual machine gui client
  ];
}
