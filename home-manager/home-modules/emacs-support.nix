{ config, pkgs, ... }:

{
  home.sessionPath = [
    "$HOME/.config/emacs/bin:$PATH"
    "$HOME/.emacs.d/bin:$PATH"
    "$HOME/.config/doom:$PATH"
  ];
  home.shellAliases = { emacs = "emacsclient -c -a 'emacs'"; };
  home.packages = (with pkgs; [
    # Packages added as dependencies for doom emacs config. Not otherwise necessary on system.
 #   nixd #Marked as insecure 3/12/24, removed to allow build without enabling insecure build
    nil
    nixfmt-classic
    file
    lemminx
    marksman
    wmctrl
    jshon
    aria
    hledger
    hunspell
    hunspellDicts.en_US-large
    pandoc
    emacsPackages.mu4e
    isync
    msmtp
    gnumake
    libxml2
    stylelint
    html-tidy
    shellcheck
    shfmt
    yaml-language-server
    emacsPackages.nix-mode
    emacsPackages.editorconfig
    nodePackages.js-beautify
    php83Packages.composer
    php83
    pipenv
    (python3.withPackages (p:
      with p; [
        pip
        exchangelib
        editorconfig
        pandas
        requests
        epc
        lxml
        pysocks
    #    pymupdf
        pytube
        markdown
        cmake
        black
        pyflakes
        isort
        nose
        pytest
        setuptools
      ]))
  ]);

}
