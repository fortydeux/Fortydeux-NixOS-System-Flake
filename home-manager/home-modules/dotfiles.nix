{config, ... }:

{ ## dotfiles.nix

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/dunst" = {
    	source = ../dotfiles/dunst;
        recursive = true;
    };

    ".config/hypr" = {
    	source = ../dotfiles/hypr;
        recursive = true;
    };
    ".config/kitty" = {
    	source = ../dotfiles/kitty;
    	recursive = true;
    };
    ".config/mako" = {
    	source = ../dotfiles/mako;
    	recursive = true;
    };
    ".config/micro" = {
    	source = ../dotfiles/micro;
    	recursive = true;
    }; 
    ".config/nvim" = {
    	source = ../dotfiles/nvim;
    	recursive = true;
    }; 
    ".config/foot" = {
    	source = ../dotfiles/foot;
    	recursive = true;
    };
    ".config/ranger" = {
    	source = ../dotfiles/ranger;
    	recursive = true;
    }; 
    ".config/wayfire.ini" = {
    	source = ../dotfiles/wayfire/wayfire.ini;
    };
    ".config/wf-shell.ini" = {
    	source = ../dotfiles/wayfire/wf-shell.ini;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
};

}