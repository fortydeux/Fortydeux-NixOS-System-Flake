{config, pkgs, ... }:

{
  imports = [
  ];

	wayland.windowManager.hyprland = {
        enable = true;
        plugins = [];
        settings = {};
		extraConfig = ''
          # This is a personalized hyprland.conf file
          # I have tried to leave a fair amount of my settings in hyprland.conf, but have removed device-specific settings to device-specific.conf
          # However, there are still some settings that may need to be changed based on the device as well as user preference, especially paths
          # There are also numerous dependencies for this hyprland.conf file to behave correctly - this may not be an exhaustive list:
          #   waybar swaylock swayidle swaybg mpvpaper
          #   wlsunset kitty fuzzel wofi rofi
          #
          #
          #
          #
          # Also be sure to check out the Keybinds section below, so you understand how to navigate this setup
          
          # Refer to the wiki for more information.
          
          # Please note not all available settings / options are set here.
          # For a full list, see the wiki
          
          ### Variables:
          ### ---------
            # See https://wiki.hyprland.org/Configuring/Keywords/ for more
            $activeBorderColor1 = rgba(DA0C81cc) # #FF6464  #DA0C81
            $activeBorderColor2 = rgba(940B92cc) # #8B4367  #940B92
            $inactiveBorderColor = rgba(383854cc) # #543864  #383854
            $swaylock = swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2
            $swaybg-x = pkill mpvpaper & swaybg -i $HOME/.config/hypr/Wallpapers/Professional/balloon-wp.jpg
            $mpvpaper-z = pkill swaybg & mpvpaper -p --slideshow 60 -o "no-audio shuffle --speed=0.3" eDP-1 $HOME/.config/hypr/Wallpapers/Fun/Garden/
            $mpvpaper-c = pkill swaybg & mpvpaper -p --slideshow 60 -o "no-audio shuffle --speed=0.3" eDP-1 $HOME/.config/hypr/Wallpapers/Fun/CyberNeon/
            $waybar = waybar -c $HOME/.config/hypr/waybar/config -s $HOME/.config/hypr/waybar/style.css
            $fuzzel = fuzzel -w 80 -b 181818ef -t ccccccff
          
          
          ### Imports:
          ### -------
            source = $HOME/.config/hypr/device-specific.conf
          
          
          ### Startup:
          ### -------
            exec-once = emacs --daemon
            exec-once = foot -s
            exec-once = $waybar
            exec-once = mako #Notifications
            exec-once = nm-applet --indicator #Network manager
            exec-once = blueman-applet #Bluetooth manager
            exec-once = pcloud
            exec-once = swayidle -w timeout 300 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
            exec-once = wlsunset -l 40.6 -L -75.4 -t 2300 -T 6500
            exec-once = $swaybg-x
          #  exec-once = sleep 5 && gsettings set org.gnome.desktop.interface gtk-theme dracula
          #  exec-once = swayidle -w timeout 900 '$swaylock' before-sleep '$swaylock'
          #  exec-once = sleep 2 & $swaylock #Consider enabling this line if using greetd instead of more robust login mgr 
          #  exec-once = nwg-dock-hyprland -d
          
          
          ### Hyprland preferences:
          ### --------------------
            # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
            input {
                kb_layout = us
                kb_variant =
                kb_model =
                kb_options =
                kb_rules =
            
                follow_mouse = 1
                natural_scroll = true
                touchpad {
                    natural_scroll = true
                    middle_button_emulation = false
                    disable_while_typing = true
                    clickfinger_behavior = true
                    scroll_factor = 2
                }
                sensitivity = 0.3 # -1.0 - 1.0, 0 means no modification.
            }
            
            general {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more
                gaps_in = 4
                gaps_out = 4
                border_size = 2
                col.active_border =  $activeBorderColor1 $activeBorderColor2 8deg #other rgba(18A2FBee) rgba(EE17FBee) 45deg
                col.inactive_border = $inactiveBorderColor #original: rgba(595959aa)
                #allow_session_lock_restore = true
                layout = dwindle
            }
            
            decoration {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more
            
                rounding = 12
               blur {
                    enabled = true
                    size = 3
                    passes = 1
                }
            
                drop_shadow = true
                shadow_range = 4
                shadow_render_power = 3
                col.shadow = rgba(1a1a1aee)
            }
            
            animations {
                enabled = true
            
                # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
                bezier = myBezier, 0.05, 0.9, 0.1, 1.05
            
                # Added from garden theme
                bezier = slow, 0, 0.85, 0.3, 1
                bezier = overshot, 0.7, 0.6, 0.1, 1.1
                bezier = bounce, 1, 1.6, 0.1, 0.85
                bezier = slingshot, 1, -2, 0.9, 1.25
                bezier = nice, 0, 6.9, 0.5, -4.20
            
            #    animation = windows, 1, 7, myBezier
                animation = windows, 1, 5, bounce, slide
                animation = windowsOut, 1, 7, default, popin 80%
                animation = border, 1, 20, default
                animation = borderangle, 1, 8, default
                animation = fade, 1, 7, default
            #    animation = workspaces, 1, 6, default
                animation = workspaces, 1, 5, overshot, slide
            
            }
            
            dwindle {
                # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
                pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = true # you probably want this
            }
            
            master {
                # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
                new_is_master = true
            }
            
            gestures {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more
                workspace_swipe = true
                workspace_swipe_fingers = 3
            }
            
            # Example per-device config
            # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
            device:epic-mouse-v1 {
                sensitivity = -0.5
            }
            device:microsoft-arc-mouse {
                sensitivity = 1
            }
            
            misc {
                disable_hyprland_logo = true
                disable_splash_rendering = true
            }
            
            # Example windowrule v1
            # windowrule = float, ^(kitty)$
            # Example windowrule v2
            # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
            # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
            
            
          ### Keybinds: 
          ### --------
            # See https://wiki.hyprland.org/Configuring/Keywords/ for more
            $mainMod = SUPER
            
            # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more ALSO https://wiki.gentoo.org/wiki/Hyprland -> another good resource for binds
            bind = $mainMod, Q, exec, kitty
            bind = CTRL ALT, T, exec, wezterm
            bind = $mainMod, RETURN, exec, footclient
            bind = $mainMod SHIFT, T, exec, alacritty 
            bind = $mainMod, C, killactive,
            bind = $mainMod, M, exit,
            bind = $mainMod, E, exec, nautilus #requires nautilus file manager installed
            bind = $mainMod, V, togglefloating,
            bind = $mainMod, D, exec, rofi -show drun -show-icons
            bind = $mainMod, W, exec, wofi -S drun -GIm -w 3 -W 100% -H 96% #wofi installed by default
            bind = $mainMod, P, pseudo, # dwindle
            bind = $mainMod, L, exec, $swaylock
            bind = $mainMod, J, togglesplit, # dwindle
            bind = $mainMod, F, fullscreen, 0
            bind = $mainMod, H, fullscreen, 1
            bind = CTRL, SPACE, exec, pkill fuzzel || $fuzzel #requires fuzzel installed
            bind = $mainMod, B, exec, pkill waybar || $waybar #requires waybar installed 
            bind = $mainMod, K, exec, kate #requires kate text editor installed
            bind =, PRINT, exec, grim -g "$(slurp)" #requires grim installed
            bind = $mainMod SHIFT, X, exec, $swaybg-x
            bind = $mainMod SHIFT, Z, exec, $mpvpaper-z
            bind = $mainMod SHIFT, C, exec, $mpvpaper-c
          
            # Volume
            bind=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            binde=, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-
            binde=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
          
            # Screen brightness
            binde = , XF86MonBrightnessDown, exec, brightnessctl set 2%- #requires brightnessctl intstalled
            binde = , XF86MonBrightnessUp, exec, brightnessctl set 2%+ #requires brightnessctl intstalled
          
            # Playerctl
            bind = , XF86AudioPlay, exec, playerctl play-pause #requires playerctl installed
          
            #Switches
            #bindl=, switch:Lid Switch, exec, $swaylock
            bind = SUPER, Escape, exec, hyprctl reload
            bind = SUPER, Escape, exec, pkill waybar && sleep 1 && $waybar &
            bind = SUPER, Escape, exec, notify-send "Config Reloaded"
            
            # Move focus with mainMod + arrow keys
            bind = $mainMod, left, movefocus, l
            bind = $mainMod, right, movefocus, r
            bind = $mainMod, up, movefocus, u
            bind = $mainMod, down, movefocus, d
            
            # Switch workspaces with mainMod + [0-9]
            bind = $mainMod, 1, workspace, 1
            bind = $mainMod, 2, workspace, 2
            bind = $mainMod, 3, workspace, 3
            bind = $mainMod, 4, workspace, 4
            bind = $mainMod, 5, workspace, 5
            bind = $mainMod, 6, workspace, 6
            bind = $mainMod, 7, workspace, 7
            bind = $mainMod, 8, workspace, 8
            bind = $mainMod, 9, workspace, 9
            bind = $mainMod, 0, workspace, 10
            
            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            bind = $mainMod SHIFT, 1, movetoworkspace, 1
            bind = $mainMod SHIFT, 2, movetoworkspace, 2
            bind = $mainMod SHIFT, 3, movetoworkspace, 3
            bind = $mainMod SHIFT, 4, movetoworkspace, 4
            bind = $mainMod SHIFT, 5, movetoworkspace, 5
            bind = $mainMod SHIFT, 6, movetoworkspace, 6
            bind = $mainMod SHIFT, 7, movetoworkspace, 7
            bind = $mainMod SHIFT, 8, movetoworkspace, 8
            bind = $mainMod SHIFT, 9, movetoworkspace, 9
            bind = $mainMod SHIFT, 0, movetoworkspace, 10
            bind = $mainMod SHIFT CTRL, right, movetoworkspace, +1
            bind = $mainMod SHIFT CTRL, left, movetoworkspace, -1
            
            # Scroll through existing workspaces with mainMod + CTRL + right/left
            bind = $mainMod + CTRL, right, workspace, e+1
            bind = $mainMod + CTRL, left, workspace, e-1
            bind = , mouse_right, workspace, e+1
            bind = , mouse_left, workspace, e-1
            bind = $mainModCTRL, mouse:273, workspace, m+1
            bind = $mainModCTRL, mouse:272, workspace, m-1
            
            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod + SHIFT, mouse:272, resizewindow
            
            # Touchscreen Gestures
            # swipe left from right edge
            bind = , edge:r:l, workspace, +1
            
            # swipe up from bottom edge
            bind = , edge:d:u, exec, firefox
            
            # swipe down from left edge
            bind = , edge:l:d, exec, pactl set-sink-volume @DEFAULT_SINK@ -4%
            
            # swipe down with 4 fingers
            bind = , swipe:4:d, killactive
            
            # swipe diagonally leftwards and downwards with 3 fingers
            # l (or r) must come before d and u
            bind = , swipe:3:ld, exec, foot
		'';
	};
}