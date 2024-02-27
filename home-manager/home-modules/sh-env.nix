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
      VISUAL = "micro";
      EDITOR = "micro";
    };
    sessionPath = [ "$HOME/.config/emacs/bin:$PATH" ];
    shellAliases = {
      emacs = "emacsclient -c -a 'emacs'";
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
