{ config, pkgs, inputs, ... }:

{ # hx-gpt.nix
  home.packages = with pkgs; [
    bun #Helix-gpt dependency...Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
  # inputs.helix-gpt.packages.${pkgs.system}.helix-gpt
  ];

  # home.activationScripts.helix-gpt.text = ''
  #   ln -sf ${inputs.helix-gpt.apps.${pkgs.system}.helix-gpt.program} $HOME/.local/bin/helix-gpt
  # '';
  
}
