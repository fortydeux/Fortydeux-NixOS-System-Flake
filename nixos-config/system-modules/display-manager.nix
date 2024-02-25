{ config, pkgs, ... }: 

{ # Display-manager.nix

	services.xserver.displayManager.sddm.enable = true;

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
