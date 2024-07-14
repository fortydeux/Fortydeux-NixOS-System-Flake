{ config, pkgs, ... }: 

{ # Security.nix

 # Security
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;
  security.doas.enable = false;

  # Services - swaylock (pam).
  security.pam.services.swaylock = {};

    # Services - Mullvad VPN
  services.mullvad-vpn.enable = true;

  #Services - clamav updater: freshclam
  # services.clamav.updater.enable = true;

  environment.systemPackages = with pkgs; [
    wireguard-tools
  	mullvad-vpn
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 24800 24802 ];
   networking.firewall.allowedUDPPorts = [ 24800 24802 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
    
}
