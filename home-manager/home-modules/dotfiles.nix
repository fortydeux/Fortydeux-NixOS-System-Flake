{config, ... }:

{ ## dotfiles.nix


  # Enable & Configure i3status-rust
  programs.i3status-rust = {
  	enable = true;
  	bars = {
 
  		     default = {
  		          blocks = [
  		             {  		             
  		                block = "cpu";
  		                info_cpu = 20;
  		                warning_cpu = 50;
  		                critical_cpu = 90;
  		             }
  		             {
  		                block = "time";
  		                interval = 5;
  		                format = " $timestamp.datetime(f:'%a %d/%m %R') ";
  		             }
  		             {  		            
  		                block = "disk_space";
  		                path = "/";
  		                info_type = "available";
  		                alert_unit = "GB";
  		                interval = 20;
  		                warning = 20.0;
  		                alert = 10.0;
  		                format = " $icon root: $available.eng(w:2) ";
  		             }
  		             {  		             
  		                block = "memory";
  		                format = " $icon $mem_total_used_percents.eng(w:2) ";
  		                format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
  		             }
  		             {  		             
  		                block = "sound";
  		             }
  		             {
  		             	block = "backlight";
  		             }
                     {
  		                block = "net";
  		             }
  		             {
  		             	block = "battery";
  		             	format = " $icon $percentage ";
  		             	missing_format = "";
  		             }

  		          ];
  		          settings = {
  		              invert_scrolling = true;
  		              theme =  {
  		                theme = "solarized-dark";
  		                overrides = {
  		                  idle_bg = "#123456";
  		                  idle_fg = "#abcdef";
  		                };
  		              };
  		            };
  		            icons = "awesome4";
  		            theme = "solarized-dark";
  		        };
    };
  };



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
    ".config/i3bar-river" = {
    	source = ../dotfiles/i3bar-river;
    	recursive = true;
    };
    # ".config/i3status-rust" = {
    # 	source = ../dotfiles/i3status-rust;
    # 	recursive = true;
    # };

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
    ".config/river" = {
    	source = ../dotfiles/river;
    	recursive = true;
    };
    ".config/sway" = {
    	source = ../dotfiles/sway;
    	recursive = true;
    };
    ".config/wayfire.ini" = {
    	source = ../dotfiles/wayfire/wayfire.ini;
    };
    ".config/wf-shell.ini" = {
    	source = ../dotfiles/wayfire/wf-shell.ini;
    };
    ".config/wayfire/wallpapers" = {
    	source = ../dotfiles/wayfire/wallpapers;
    	recursive = true;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

};

}
