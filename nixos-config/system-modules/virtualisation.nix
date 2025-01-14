{ config, pkgs, ... }:

{ # Virtualization.nix

  #Services - Virtualization
  # virtualisation.virtualbox.host.enable = true;
  virtualisation.libvirtd = {
    enable = true;
  };
#  virtualisation.waydroid.enable = true;
  # virtualisation.docker.enable = true; #Open source project to pack, ship and run any application as a lightweight container.
  # virtualisation.docker.rootless = { #Open source project to pack, ship and run any application as a lightweight container.
  #   enable = true;
  #   setSocketVariable = true;
  # }; 
  # Podman config
  users.users.fortydeux = {
    extraGroups =
      [ "libvirtd" ];
  };
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  programs.virt-manager.enable = true;
  
  # Packages
  environment.systemPackages = with pkgs; [
    boxbuddy # Unofficial GUI for managing your Distroboxes, written with GTK4 + Libadwaita
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    #podman-compose # start group of containers for dev    
    distrobox #Wrapper around podman or docker to create and start containers.    
    gnome-boxes # Virtual machine gui client
    qemu # Virtual machine client CLI
    spice # Complete open source solution for interaction with virtualized desktop devices
  ];
}
