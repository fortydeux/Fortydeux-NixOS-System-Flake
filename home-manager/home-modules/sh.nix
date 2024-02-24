{ config, pkgs, ... }

{
  home = {
    sessionVariables = {
      # EDITOR = "emacs";
      VISUAL = "micro";
      EDITOR = "micro";
    };
    sessionPath = [ "$HOME/.emacs.d/bin:$PATH" ];
    shellAliases = {
      emacs = "emacsclient -c -a 'emacs'";
      ls = "lsd -lh --group-directories-first --color-always --icon-always";
      cat = "bat -f";
    };
  };

  programs.zsh = {
    enable = true;
    enableAutoSuggestions = true;
    enableCompletion = true;
    initExtra = ''
      neofetch
      eval "$(zoxide init zsh)"
    '';
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
