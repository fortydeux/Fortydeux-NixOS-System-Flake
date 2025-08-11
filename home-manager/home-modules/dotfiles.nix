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
  		                format = " $timestamp.datetime(f:'%a %m/%d %R') ";
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
  		              missing_format = "";
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
    # ".config/helix" = {
    # 	source = ../dotfiles/helix;
    #     recursive = true;
    # };
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
    
    ".config/logos" = {
    	source = ../dotfiles/logos;
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

    # Niri config now managed by niri-config.nix module
    # ".config/niri" = {
    # 	source = ../dotfiles/niri;
    # 	recursive = true;
    # };
    
    # Still write waybar config files for niri
    ".config/niri/waybar" = {
    	source = ../dotfiles/niri/waybar;
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

    ".config/scripts" = {
    	source = ../dotfiles/scripts;
    	recursive = true;
    };

    ".config/sway" = {
    	source = ../dotfiles/sway;
    	recursive = true;
    };
    
    ".config/nwg-bar" = {
    	source = ../dotfiles/miracle-wm/nwg-bar;
    	recursive = true;
    };

    ".config/nwg-panel" = {
    	source = ../dotfiles/miracle-wm/nwg-panel;
    	recursive = true;
    };

    ".config/nwg-drawer" = {
    	source = ../dotfiles/miracle-wm/nwg-drawer;
    	recursive = true;
    };
    
    ".config/nwg-dock" = {
    	source = ../dotfiles/miracle-wm/nwg-dock;
    	recursive = true;
    };
    
    ".config/miracle-wm" = {
    	source = ../dotfiles/miracle-wm;
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
    
    ".config/wallpapers" = {
    	source = ../dotfiles/wallpapers;
    	recursive = true;
    };  

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

};

}
