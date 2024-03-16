{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
      # neofetch|lolc
      eval "$(zoxide init zsh)"
      eval "$(starship init zsh)"
    '';
  };
  home = {
    sessionVariables = {
      # EDITOR = "emacs";
      VISUAL = "micro";
      EDITOR = "micro";
    };
    shellAliases = {
      ls = "lsd -lh --group-directories-first --color always --icon always";
      cat = "bat -f";
      rrr = "ranger";
      ff = "cd ~/fortyflake";
      ffr = "cd ~/fortyflake && ranger";
      stat = "git status";
      st = "git status -s";
    };
  };
  home.packages = (with pkgs; [
    starship
    lsd
    eza
    bat
    direnv
    nix-direnv
    fd
    gnused
    gnugrep
    ripgrep
    zoxide
  ]);
}
