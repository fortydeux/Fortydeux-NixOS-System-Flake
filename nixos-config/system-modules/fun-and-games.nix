{ config, pkgs, ... }: 

{ # Fun-and-games.nix
	
  # Enable Steam - Steam games distribution
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  environment.systemPackages = with pkgs; [
    ## Games support
    lutris #Open Source gaming platform for GNU/Linux
 
    ## Candy - not necessary
    cava #Console-based Audio Visualizer for Alsa
    cbonsai #Grow bonsai trees in your terminal
    cmatrix #Simulates the falling characters theme from The Matrix movie
    cool-retro-term #erminal emulator which mimics the old cathode display
    distrobox
    hollywood #Fill your console with Hollywood melodrama technobabble
    nms #A command line tool that recreates the famous data decryption effect seen in the 1992 movie Sneakers.
    pipes #Animated pipes terminal screensaver
    tty-clock #Digital clock in ncurses
    vitetris #Terminal-based Tetris clone by Victor Nilsson
  ];

}
