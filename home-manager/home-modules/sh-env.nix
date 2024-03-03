{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
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
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
    shellAliases = {
      ls = "lsd -lh --group-directories-first --color always --icon always";
      cat = "bat -f";
      rrr = "ranger";
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
