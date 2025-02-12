{ config, pkgs, inputs, ... }:

{
   home.packages = with pkgs; [
    openai-whisper # General-purpose speech recognition model
  ];  
}
