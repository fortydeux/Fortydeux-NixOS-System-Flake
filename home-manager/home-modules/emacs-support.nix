{ config, pkgs, ... }:

{
  home.packages = (with pkgs; [
    # Packages added as dependencies for doom emacs config. Not otherwise necessary on system.
    nil
    nixfmt
    file
    wmctrl
    jshon
    aria
    hledger
    hunspell hunspellDicts.en_US-large
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
    emacsPackages.nix-mode
    emacsPackages.editorconfig
    nodePackages.js-beautify
    php83Packages.composer
    php83
    pipenv
    (python3.withPackages (p: with p; [
      editorconfig
      pandas
      requests
      epc lxml
      pysocks
      pymupdf
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
