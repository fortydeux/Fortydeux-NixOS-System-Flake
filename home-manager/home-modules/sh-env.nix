{ config, pkgs, ... }:

{
  # Bash Shell
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
  # Zsh shell
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
  # Fish Shell
  programs.fish = {
    enable = true;
  };
  # Atuin shell history
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };
  # Session variables and shell aliases
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
      fff = "cd ~/fortyflake && fish";
      stat = "git status";
      st = "git status -s";
    };
  };
  # Nix-direnv
  programs.direnv = {
      enable = true;
      # enableBashIntegration = true;
      # enableFishIntegration = true;
      # enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  #Shell-related packages
  home.packages = (with pkgs; [
    starship
    lsd
    eza
    bat
    # direnv
    # nix-direnv
    fd
    gnused
    gnugrep
    ripgrep
    zoxide
  ]);
}
