{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
      # fastfetch|lolc
      eval "$(zoxide init zsh)"
      eval "$(starship init zsh)"
      eval "$(gh copilot alias -- zsh)"
    '';
  };
  programs.fish = {
    enable = true;
  };
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };
  home = {
    sessionVariables = {
      # EDITOR = "emacs";
      VISUAL = "hx";
      EDITOR = "hx";
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
