{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    openai-whisper # General-purpose speech recognition model
  ];  
}
