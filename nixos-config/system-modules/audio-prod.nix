# audio-prod.nix
{ pkgs, inputs, ... }:

{
  imports = [
    inputs.musnix.nixosModules.musnix
  ];

  musnix = {
    enable = true;
    rtcqs.enable = true;
    ffado.enable = true;
    soundcardPciId = "00:1f.3";
  };

  # FireWire DMA timeout prevention
  boot.kernelParams = [
    "firewire_ohci.quirks=0x2"    # Enable compatibility quirks
    "firewire_ohci.debug=0"       # Reduce debug overhead
  ];

  # Prevent power management interference with FireWire audio
  services.udev.extraRules = ''
    # Keep FireWire controller active
    SUBSYSTEM=="pci", ATTR{vendor}=="0x1106", ATTR{device}=="0x3044", ATTR{power/control}="on"
    SUBSYSTEM=="firewire", ACTION=="add", ATTR{power/control}="on"
    # Keep Focusrite Saffire Pro 40 active
    SUBSYSTEM=="firewire", ATTR{guid}=="0x00130e040140b9f4", ATTR{power/control}="on"
  '';

  # Low-latency settings for pipewire
  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 32;
      "default.clock.min-quantum" = 32;
      "default.clock.max-quantum" = 512;
    };
  };

  environment.systemPackages = with pkgs; [
    zrythm #Automated and intuitive digital audio workstation
    qjackctl # JACK control GUI
    carla
    yabridge
    yabridgectl
    helvum
    jack2 
    # ffado
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
