{
  config,
  pkgs,
  inputs,
  ...
}:

# let
#   system = pkgs.hostPlatform.system;
# in
{
  imports =
    [
    ];
  services.hyprpaper = {
    enable = true;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    # package = pkgs.hyprland;
    # systemd.variables = ["--all"];
    plugins = [
      # Hyprexpo plugin
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      # pkgs.hyprlandPlugins.hyprexpo
      # Hyprgrass plugin
      inputs.hyprgrass.packages.${pkgs.system}.hyprgrass
      # Hyprscroller plugin
      inputs.hyprscroller.packages.${pkgs.system}.hyprscroller
      # pkgs.hyprlandPlugins.hyprscroller
      # Hyprscpace plugin
      inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
      # pkgs.hyprlandPlugins.hyprspace
      # Hyprland Virtual Desktops Plugin
      # inputs.hyprland-virtual-desktops.packages.${pkgs.system}.virtual-desktops
      # Hyprsplit Plugin
      inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
      # pkgs.hyprlandPlugins.hyprsplit
    ];
    settings = {
      "$mainMod" = "SUPER";
      "$activeBorderColor1" = "rgba(da0c81cc)";
      "$activeBorderColor2" = "rgba(940b92cc)";
      "$inactiveBorderColor" = "rgba(00000099)";
      "$swaylock" = "swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2";
      "$swaybg-x" = "pkill mpvpaper & swaybg -m fill -i $HOME/.config/hypr/Wallpapers/Professional/balloon-wp.jpg";
      "$mpvpaper-z" = "pkill swaybg & mpvpaper -p --slideshow 60 -o 'no-audio shuffle --speed=0.3' eDP-1 $HOME/.config/hypr/Wallpapers/Fun/Garden/";
      "$mpvpaper-c" = "pkill swaybg & mpvpaper -p --slideshow 60 -o 'no-audio shuffle --speed=0.3' eDP-1 $HOME/.config/hypr/Wallpapers/Fun/CyberNeon/";
      "$removeWallpapers" = "pkill swaybg || pkill mpvpaper";
      "$waybar" = "waybar -c $HOME/.config/hypr/waybar/config -s $HOME/.config/hypr/waybar/style.css";
      "$fuzzel" = "fuzzel -w 80 -b 181818ef -t ccccccff";
      "$hypridle" = "hypridle";
      "$hyprlock" = "hyprlock";
      # "source" = "$HOME/.config/hypr/device-specific.conf";
      exec-once = [
        "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY"
        "hyprctl setcursor phinger-cursors 32"
        "emacs --daemon"
        "foot -s"
        "$waybar"
        "mako"
        "nm-applet --indicator"
        "blueman-applet"
        "pcloud"
        "wlsunset -l 40.6 -L -75.4 -t 2300 -T 6500"
        # "$swaybg-x"
        "$hypridle"

      ];
      input = {
        kb_layout = "us";

        follow_mouse = 1;
        natural_scroll = true;
        touchpad = {
          natural_scroll = true;
          middle_button_emulation = false;
          disable_while_typing = true;
          clickfinger_behavior = true;
          scroll_factor = 2;
        };
        sensitivity = 0.3;
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        gaps_in = 4;
        gaps_out = 4;
        border_size = 2;
        # "col.active_border" =  "$activeBorderColor1 $activeBorderColor2 8deg";
        # "col.inactive_border" = "$inactiveBorderColor";
        #allow_session_lock_restore = true
        # layout = "dwindle";
        layout = "scroller";
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 12;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        # drop_shadow = true;
        # shadow_range = 4;
        # shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aed)";
      };

      animations = {
        enabled = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"

          # Added from garden theme
          "slow, 0, 0.85, 0.3, 1"
          "overshot, 0.7, 0.6, 0.1, 1.1"
          "bounce, 1, 1.6, 0.1, 0.85"
          "slingshot, 1, -2, 0.9, 1.25"
          "nice, 0, 6.9, 0.5, -4.20"
        ];
        #    animation = windows, 1, 7, myBezier
        animation = [
          "windows, 1, 5, bounce, slide"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 20, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          #    animation = workspaces, 1, 6, default
          "workspaces, 1, 5, overshot, slide"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_status = "master";
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_cancel_ratio = 0.15;
      };

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device = {
        name = "microsoft-arc-mouse";
        sensitivity = 1;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
      bind = [
        "$mainMod, S, exec, kitty"
        "CTRL ALT, T, exec, wezterm"
        "$mainMod, RETURN, exec, footclient"
        "$mainMod SHIFT, T, exec, alacritty"
        "$mainMod, Q, killactive,"
        "$mainModSHIFT, E, exit,"
        "$mainMod, E, exec, nautilus"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, rofi -show drun -show-icons"
        "$mainMod, W, exec, wofi -S drun -GIm -w 3 -W 100% -H 96%"
        "$mainMod, P, pseudo, "
        "$mainMod, L, exec, $hyprlock"
        "$mainMod, J, togglesplit, "
        "$mainMod, F, fullscreen, 0"
        "$mainMod, H, fullscreen, 1"
        "CTRL, SPACE, exec, pkill fuzzel || $fuzzel"
        "$mainMod, B, exec, pkill waybar || $waybar"
        "$mainMod, K, exec, kate"
        "$mainMod SHIFT, X, exec, $swaybg-x"
        "$mainMod SHIFT, Z, exec, $mpvpaper-z"
        "$mainMod SHIFT, C, exec, $mpvpaper-c"
        "$mainMod SHIFT, B, exec, $removeWallpapers"

        # Volume
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Playerctl
        ", XF86AudioPlay, exec, playerctl play-pause"

        #Switches
        "SUPER, Escape, exec, hyprctl reload"
        "SUPER, Escape, exec, pkill waybar && sleep 1 && $waybar &"
        "SUPER, Escape, exec, notify-send 'Config Reloaded'"

        # Move focus with mainMod + arrow keys
        # "$mainMod, left, movefocus, l"
        # "$mainMod, right, movefocus, r"
        # "$mainMod, up, movefocus, u"
        # "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        # "$mainMod, 1, workspace, 1"
        # "$mainMod, 2, workspace, 2"
        # "$mainMod, 3, workspace, 3"
        # "$mainMod, 4, workspace, 4"
        # "$mainMod, 5, workspace, 5"
        # "$mainMod, 6, workspace, 6"
        # "$mainMod, 7, workspace, 7"
        # "$mainMod, 8, workspace, 8"
        # "$mainMod, 9, workspace, 9"
        # "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        # "$mainMod SHIFT, 1, movetoworkspace, 1"
        # "$mainMod SHIFT, 2, movetoworkspace, 2"
        # "$mainMod SHIFT, 3, movetoworkspace, 3"
        # "$mainMod SHIFT, 4, movetoworkspace, 4"
        # "$mainMod SHIFT, 5, movetoworkspace, 5"
        # "$mainMod SHIFT, 6, movetoworkspace, 6"
        # "$mainMod SHIFT, 7, movetoworkspace, 7"
        # "$mainMod SHIFT, 8, movetoworkspace, 8"
        # "$mainMod SHIFT, 9, movetoworkspace, 9"
        # "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod SHIFT CTRL, right, movetoworkspace, +1"
        "$mainMod SHIFT CTRL, left, movetoworkspace, -1"

        # Scroll through existing workspaces with mainMod + CTRL + right/left
        "$mainMod + CTRL, right, workspace, e+1"
        "$mainMod + CTRL, left, workspace, e-1"
        ", mouse_right, workspace, e+1"
        ", mouse_left, workspace, e-1"
        "$mainModCTRL, mouse:273, workspace, m+1"
        "$mainModCTRL, mouse:272, workspace, m-1"

        # Virtual-desktop Keybinds
        # "$mainModCTRL, right, nextdesk"
        # "$mainModCTRL, left, prevdesk"

        # Touchscreen Gestures
        # swipe left from right edge
        ", edge:r:l, workspace, +1"

        # swipe up from bottom edge
        ", edge:d:u, exec, firefox"

        # swipe down from left edge
        ", edge:l:d, exec, pactl set-sink-volume @DEFAULT_SINK@ -4%"

        # swipe down with 4 fingers
        ", swipe:4:d, killactive"

        # swipe diagonally leftwards and downwards with 3 fingers
        # l (or r) must come before d and u
        ", swipe:3:ld, exec, foot"

        # Overview mini-modes
        # Hyprexpo
        "SUPER, grave, hyprexpo:expo, toggle # can be: toggle, off/disable or on/enable"
        # Hyprspace
        "$mainMod, A, overview:toggle"
      ];

      binde = [
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"

        # Screen brightness
        ", XF86MonBrightnessDown, exec, brightnessctl set 2%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 2%+"
      ];

      bindl = [
        #Switches
        ", switch:Lid Switch, exec, $hyprlock"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod + SHIFT, mouse:272, resizewindow"
      ];

      plugin = {
        # virtual-desktops = {
        #   cycleworkspaces = 1;
        #   rememberlayout = "size";
        # };
        hyprexpo = {
          columns = 3;
          gap_size = 5;
          bg_col = "rgb(111111)";
          workspace_method = "first current"; # [center/first] [workspace] e.g. first 1 or center m+1
          enable_gesture = true; # laptop touchpad, 4 fingers
          gesture_distance = 300; # how far is the "max"
          gesture_positive = true; # positive = swipe down. Negative = swipe up.
        };
        hyprsplit = {
          num_workspaces = 8;
        };
        scroller = {
          column_default_width = "floating";
          focus_wrap = false;
          # ultra-wide monitor
          column_widths = "onesixth onefourth onethird onehalf twothirds one";
          # portrait mode monitors
          monitor_modes = "eDP-1=col,DP-1=col,HDMI-A-1=col";
        };
        touch_gestures = {
          # default sensitivity is probably too low on tablet screens,
          # I recommend turning it up to 4.0
          sensitivity = 4.0;
          workspace_swipe_fingers = 3;
        };
      };
    };
    extraConfig = ''
      # Environment Variables for the Hyprland session:
      # ----------------------------------------------
      env=XDG_CURRENT_DESKTOP,Hyprland
      env=XDG_SESSION_TYPE,wayland
      env=XDG_SESSION_DESKTOP,Hyprland
      env=_JAVA_AWT_WM_NONREPARENTING,1
      env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env=MOZ_ENABLE_WAYLAND,1
      env=QT_QPA_PLATFORM,wayland;xcb
      env=GDK_BACKEND,wayland,x11
      env=WLR_NO_HARDWARE_CURSORS,1
      env=SDL_VIDEODRIVER,wayland
      env=CLUTTER_BACKEND,wayland
      env=QT_AUTO_SCREEN_SCALE_FACTOR,1
      # env=HYPRCURSOR_THEME,phinger-cursors-light
      # env=GTK_THEME,Dracula
      env=HYPRCURSOR_SIZE,32
      # env=QT_QPA_PLATFORMTHEME,qt6ct

      # Screenshots
      bind = , PRINT, exec, grim -g "$(slurp)"

      # Hyprsplit
      bind = SUPER, 1, split:workspace, 1
      bind = SUPER, 2, split:workspace, 2
      bind = SUPER, 3, split:workspace, 3
      bind = SUPER, 4, split:workspace, 4
      bind = SUPER, 5, split:workspace, 5
      bind = SUPER, 6, split:workspace, 6
      bind = SUPER, 7, split:workspace, 7
      bind = SUPER, 8, split:workspace, 8

      bind = SUPER SHIFT, 1, split:movetoworkspacesilent, 1
      bind = SUPER SHIFT, 2, split:movetoworkspacesilent, 2
      bind = SUPER SHIFT, 3, split:movetoworkspacesilent, 3
      bind = SUPER SHIFT, 4, split:movetoworkspacesilent, 4
      bind = SUPER SHIFT, 5, split:movetoworkspacesilent, 5
      bind = SUPER SHIFT, 6, split:movetoworkspacesilent, 6
      bind = SUPER SHIFT, 7, split:movetoworkspacesilent, 7
      bind = SUPER SHIFT, 8, split:movetoworkspacesilent, 8

      bind = SUPER, P, split:swapactiveworkspaces, current +1
      bind = SUPER, G, split:grabroguewindows

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, scroller:movefocus, l
      bind = $mainMod, right, scroller:movefocus, r
      bind = $mainMod, up, scroller:movefocus, u
      bind = $mainMod, down, scroller:movefocus, d
      bind = $mainMod, home, scroller:movefocus, begin
      bind = $mainMod, end, scroller:movefocus, end

      # Movement
      bind = $mainMod SHIFT, left, scroller:movewindow, l
      bind = $mainMod SHIFT, right, scroller:movewindow, r
      bind = $mainMod SHIFT, up, scroller:movewindow, u
      bind = $mainMod SHIFT, down, scroller:movewindow, d
      bind = $mainMod SHIFT, home, scroller:movewindow, begin
      bind = $mainMod SHIFT, end, scroller:movewindow, end

      # Modes
      bind = $mainMod, bracketleft, scroller:setmode, row
      bind = $mainMod, bracketright, scroller:setmode, col

      # Sizing keys
      bind = $mainMod, equal, scroller:cyclesize, next
      bind = $mainMod, minus, scroller:cyclesize, prev

      # Admit/Expel
      bind = $mainMod, I, scroller:admitwindow,
      bind = $mainMod, O, scroller:expelwindow,

      # Center submap
      # will switch to a submap called center
      bind = $mainMod, C, submap, center
      # will start a submap called "center"
      submap = center
      # sets repeatable binds for resizing the active window
      bind = , C, scroller:alignwindow, c
      bind = , C, submap, reset
      bind = , right, scroller:alignwindow, r
      bind = , right, submap, reset
      bind = , left, scroller:alignwindow, l
      bind = , left, submap, reset
      bind = , up, scroller:alignwindow, u
      bind = , up, submap, reset
      bind = , down, scroller:alignwindow, d
      bind = , down, submap, reset
      # use reset to go back to the global submap
      bind = , escape, submap, reset
      # will reset the submap, meaning end the current one and return to the global one
      submap = reset

      # Resize submap
      # will switch to a submap called resize
      bind = $mainMod SHIFT, R, submap, resize
      # will start a submap called "resize"
      submap = resize
      # sets repeatable binds for resizing the active window
      binde = , right, resizeactive, 100 0
      binde = , left, resizeactive, -100 0
      binde = , up, resizeactive, 0 -100
      binde = , down, resizeactive, 0 100
      # use reset to go back to the global submap
      bind = , escape, submap, reset
      # will reset the submap, meaning end the current one and return to the global one
      submap = reset

      # Fit size submap
      # will switch to a submap called fitsize
      bind = $mainMod, R, submap, fitsize
      # will start a submap called "fitsize"
      submap = fitsize
      # sets binds for fitting columns/windows in the screen
      bind = , W, scroller:fitsize, visible
      bind = , W, submap, reset
      bind = , right, scroller:fitsize, toend
      bind = , right, submap, reset
      bind = , left, scroller:fitsize, tobeg
      bind = , left, submap, reset
      bind = , up, scroller:fitsize, active
      bind = , up, submap, reset
      bind = , down, scroller:fitsize, all
      bind = , down, submap, reset
      # use reset to go back to the global submap
      bind = , escape, submap, reset
      # will reset the submap, meaning end the current one and return to the global one
      submap = reset

      # overview keys
      # bind key to toggle overview (normal)
      bind = $mainMod, tab, scroller:toggleoverview
      # overview submap
      # will switch to a submap called overview
      bind = $mainMod, tab, submap, overview
      # will start a submap called "overview"
      submap = overview
      bind = , right, scroller:movefocus, right
      bind = , left, scroller:movefocus, left
      bind = , up, scroller:movefocus, up
      bind = , down, scroller:movefocus, down
      # use reset to go back to the global submap
      bind = , escape, scroller:toggleoverview,
      bind = , escape, submap, reset
      bind = , return, scroller:toggleoverview,
      bind = , return, submap, reset
      bind = $mainMod, tab, scroller:toggleoverview,
      bind = $mainMod, tab, submap, reset
      # will reset the submap, meaning end the current one and return to the global one
      submap = reset

      # Marks
      bind = $mainMod, M, submap, marksadd
      submap = marksadd
      bind = , a, scroller:marksadd, a
      bind = , a, submap, reset
      bind = , b, scroller:marksadd, b
      bind = , b, submap, reset
      bind = , c, scroller:marksadd, c
      bind = , c, submap, reset
      bind = , escape, submap, reset
      submap = reset

      bind = $mainMod SHIFT, M, submap, marksdelete
      submap = marksdelete
      bind = , a, scroller:marksdelete, a
      bind = , a, submap, reset
      bind = , b, scroller:marksdelete, b
      bind = , b, submap, reset
      bind = , c, scroller:marksdelete, c
      bind = , c, submap, reset
      bind = , escape, submap, reset
      submap = reset

      bind = $mainMod, apostrophe, submap, marksvisit
      submap = marksvisit
      bind = , a, scroller:marksvisit, a
      bind = , a, submap, reset
      bind = , b, scroller:marksvisit, b
      bind = , b, submap, reset
      bind = , c, scroller:marksvisit, c
      bind = , c, submap, reset
      bind = , escape, submap, reset
      submap = reset

      bind = $mainMod CTRL, M, scroller:marksreset
    '';
  };
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [config.wayland.windowManager.hyprland.package];
  #   configPackages = [config.wayland.windowManager.hyprland.package];
  # };
}
