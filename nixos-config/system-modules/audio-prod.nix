# audio-prod.nix
{ lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.musnix.nixosModules.musnix
  ];

  musnix = {
    enable = true;
    rtcqs.enable = true;
    ffado.enable = true;
    # soundcardPciId = "00:1f.3";
    # rtirq = {
    #   # highList = "snd_hrtimer";
    #   resetAll = 1;
    #   prioLow = 0;
    #   enable = true;
    #   nameList = "rtc0 snd";
    # };
  };

  # Replace pipewire with JACK
  # services.pipewire.enable = lib.mkForce false;
  # services.jack = {
  #   jackd.enable = true;
  #   # support ALSA only programs via ALSA JACK PCM plugin
  #   alsa.enable = true;
  #   # support ALSA only programs via loopback device (supports programs like Steam)
  #   # loopback = {
  #   #   enable = true;
  #   #   # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
  #   #   #dmixConfig = ''
  #   #   #  period_size 2048
  #   #   #'';
  #   # };
  # };
  
  # FireWire DMA timeout prevention
  # boot.kernelParams = [
  #   "firewire_ohci.quirks=0x2"    # Enable compatibility quirks
  #   "firewire_ohci.debug=0"       # Reduce debug overhead
  # ];

  # # Prevent power management interference with FireWire audio
  # services.udev.extraRules = ''
  #   # Keep FireWire controller active
  #   SUBSYSTEM=="pci", ATTR{vendor}=="0x1106", ATTR{device}=="0x3044", ATTR{power/control}="on"
  #   SUBSYSTEM=="firewire", ACTION=="add", ATTR{power/control}="on"
  #   # Keep Focusrite Saffire Pro 40 active
  #   SUBSYSTEM=="firewire", ATTR{guid}=="0x00130e040140b9f4", ATTR{power/control}="on"
  # '';

  # Low-latency settings for pipewire
  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 256;
      "default.clock.min-quantum" = 256;
      "default.clock.max-quantum" = 256;
    };
  };

  # WirePlumber configuration for ALSA devices
  # services.pipewire.wireplumber = {
  #   enable = true;
  #   extraConfig = {
  #     "alsa-monitor-pro40" = {
  #       "monitor.alsa.rules" = [
  #         {
  #           matches = [ 
  #             { 
  #               "device.name" = "~alsa_card.*Pro40.*";
  #             }
  #           ];
  #           actions = {
  #             "update-props" = {
  #               "api.alsa.period-size" = 256;
  #               "api.alsa.headroom" = 0;
  #             };
  #           };
  #         }
  #       ];
  #     };
  #   };
  # };
    
  systemd.user.services.pipewire.serviceConfig = {
    CPUSchedulingPolicy = "rr";             # Real-time round-robin
    CPUSchedulingPriority = 99;              # Highest priority
  };

  environment.systemPackages = with pkgs; [
    # zrythm #Automated and intuitive digital audio workstation - Temporarily affected by Cython build issue
    qjackctl # JACK control GUI
    # carla # Temporarily disabled due to Cython build issue
    yabridge
    yabridgectl
    helvum
    jack2
    libjack2
    pavucontrol 
    ffado
    ffado-mixer
    
    # FireWire audio interface recovery script
    (writeShellScriptBin "fix-focusrite" ''
      echo "=== Focusrite FireWire Recovery ==="
      echo "Reloading FireWire driver..."
      sudo ${kmod}/bin/modprobe -r firewire_ohci
      sleep 1
      sudo ${kmod}/bin/modprobe firewire_ohci
      sleep 2
      
      echo "Restarting audio services..."
      systemctl --user restart pipewire wireplumber pipewire-pulse
      sleep 5
      
      echo "Checking if interface is back..."
      if ${pipewire}/bin/pw-cli ls Node | grep -q firewire; then
          echo "✓ Focusrite detected in PipeWire"
          echo "Now toggle Studio One: No Audio Device → JACK Audio Connection Kit"
      else
          echo "✗ Interface still not detected, may need system restart"
      fi
    '')
  ];
}
