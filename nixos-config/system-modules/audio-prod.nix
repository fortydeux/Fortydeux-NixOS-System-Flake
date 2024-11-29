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

  environment.systemPackages = with pkgs; [
    zrythm #Automated and intuitive digital audio workstation
  ];
}
