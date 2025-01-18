{ config, pkgs, ... }: 

{ # Display-manager.nix

  # Enable Cosmic Greeter / Display Manager
  # services.displayManager.cosmic-greeter.enable = true;

  #Enable SDDM Display manager
 services.displayManager = {
    enable = true;
    sddm.enable = true;
    sddm.wayland.enable = true;
  };

  # Enable NumLock at login:
  services.displayManager.sddm.autoNumlock = true;

   # Greetd - enable if disabling other login managers 
 #  services.greetd = {
 #    enable = true;
 #  #  settings = {
 #  #    default_session = {
 #  #      command = "${pkgs.hyprland}/bin/Hyprland --config ${hyprConfig}";
 #  #    };
 #  #  };
 #    settings = rec {
 #      initial_session = {
 #        command = "${pkgs.hyprland}/bin/Hyprland";
 #        user = "fortydeux";
 #      };
 #      default_session = initial_session;
 #    };
 #  };	
}
