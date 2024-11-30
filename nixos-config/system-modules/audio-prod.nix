# audio-prod.nix
{ pkgs, inputs, ... }:

{
  imports = [
    inputs.musnix.nixosModules.musnix
  ];

  musnix = {
    enable = true;
    rtcqs.enable = true;
  };

  # Enable real-time audio
  security.rtkit.enable = true;
  
  # Additional real-time settings
  systemd.user.services.pipewire.serviceConfig = {
    LimitRTPRIO = 99;
    LimitMEMLOCK = "infinity";
    LimitNICE = "-20";
  };

  # Configure real-time privileges and memory locking
  security.pam.loginLimits = [
    # Real-time priority for audio group - soft limit
    {
      domain = "@audio";
      item = "rtprio";
      type = "soft";
      value = 99;
    }
    # Real-time priority for audio group - hard limit
    {
      domain = "@audio";
      item = "rtprio";
      type = "hard";
      value = 99;
    }
    # Memory locking for audio group - soft limit
    {
      domain = "@audio";
      item = "memlock";
      type = "soft";
      value = "unlimited";
    }
    # Memory locking for audio group - hard limit
    {
      domain = "@audio";
      item = "memlock";
      type = "hard";
      value = "unlimited";
    }
    # Nice level for audio group - soft limit
    {
      domain = "@audio";
      item = "nice";
      type = "soft";
      value = -20;
    }
    # Nice level for audio group - hard limit
    {
      domain = "@audio";
      item = "nice";
      type = "hard";
      value = -20;
    }
  ];

  # Enable JACK support
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    zrythm #Automated and intuitive digital audio workstation
    qjackctl # JACK control GUI
  ];

}
