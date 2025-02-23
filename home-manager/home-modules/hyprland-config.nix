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
  home.packages = with pkgs; [
    # inputs.hyprland-qtutils.packages.${pkgs.system}.default
    iio-hyprland
  ];
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ]; 
  };
  wayland.windowManager.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.default;
    # package = pkgs.hyprland;
    # systemd.variables = ["--all"];
    plugins = [
      # Hyprgrass plugin
      pkgs.hyprlandPlugins.hyprgrass
      # inputs.hyprgrass.packages.${pkgs.system}.hyprgrass
      # Hyprscroller plugin
      pkgs.hyprlandPlugins.hyprscroller
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
      "$wofi" = "wofi -S drun -GIm -w 3 -W 100% -H 96%";
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
        "iio-hyprland"
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
        workspace_swipe = false;
        # workspace_swipe_fingers = 4;
        # workspace_swipe_cancel_ratio = 0.15;
      };

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device = {
        name = "microsoft-arc-mouse";
        sensitivity = 1;
      };
      monitor = [
        "eDP-1,preferred,auto,2,transform,0"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
      bind = [
        "$mainMod, S, exec, kitty"
        "CTRL ALT, T, exec, wezterm"
        "$mainMod, RETURN, exec, ghostty"
        "$mainMod SHIFT, T, exec, alacritty"
        "$mainMod, Q, killactive,"
        "$mainModSHIFT, E, exit,"
        "$mainMod, E, exec, nautilus"
        "$mainMod, SPACE, togglefloating,"
        "$mainMod, D, exec, rofi -show drun -show-icons"
        "$mainMod, W, exec, pkill wofi || $wofi"
        "$mainMod, P, pseudo, "
        "$mainMod, L, exec, $hyprlock"
        "$mainMod, J, togglesplit, "
        "$mainMod, F, fullscreen, 0"
        "$mainMod, H, fullscreen, 1"
        "CTRL, SPACE, exec, pkill fuzzel || $fuzzel"
        "$mainMod, B, exec, pkill waybar || $waybar"
        "$mainMod, K, exec, kate"
        "$mainMod, R, exec, hyprctl seterror disable"
        "$mainMod SHIFT, X, exec, $swaybg-x"
        "$mainMod SHIFT, Z, exec, $mpvpaper-z"
        "$mainMod SHIFT, C, exec, $mpvpaper-c"
        "$mainMod SHIFT, B, exec, $removeWallpapers"
        # "$mainMod, slash, exec, $show_binds"

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
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod SHIFT CTRL, right, movetoworkspace, +1"
        "$mainMod SHIFT CTRL, left, movetoworkspace, -1"

        # Scroll through existing workspaces with mainMod + CTRL + right/left
        "$mainMod + CTRL, right, workspace, e+1"
        "$mainMod + CTRL, left, workspace, e-1"
        "$mainMod + CTRL, down, workspace, empty"
        ", mouse_right, workspace, e+1"
        ", mouse_left, workspace, e-1"
        "$mainModCTRL, mouse:273, workspace, m+1"
        "$mainModCTRL, mouse:272, workspace, m-1"
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
        # Hyprscroller
        scroller = {
          mode = "column";
          column_default_width = "one";
          focus_wrap = false;
          # ultra-wide monitor
          column_widths = "onesixth onefourth onethird onehalf twothirds fivesixths one";
          # portrait mode monitors          
          monitor_options = "(eDP-1 = (mode = col; column_default_width = one;), DP-1 = (mode = col; column_default_width = onehalf;),  HDMI-A-1 = (mode = col; column_default_width = one;))";
          gesture_scroll_distance = 200;
          gesture_workspace_switch_fingers = 4;
        };
        # Hyprgrass
        touch_gestures = {
          workspace_swipe_fingers = 4;
          # default sensitivity is probably too low on tablet screens,
          # I recommend turning it up to 4.0
          sensitivity = 8.0;
          # NOTE: swipe events only trigger for finger count of >= 3
          hyprgrass-bind = [
            " , swipe:3:l, movefocus, r"
            " , swipe:3:r, movefocus, l"
            " , swipe:3:u, movefocus, d"
            " , swipe:3:d, movefocus, u"
            " , swipe:4:u, scroller:jump"
            " , swipe:4:d, scroller:toggleoverview"
            " , swipe:3:ld, killactive"
            " , swipe:3:ru, exec, $wofi"
            " , swipe:3:lu, exec, wvkbd-mobintl"
            " , swipe:3:rd, exec, pkill wvkbd-mobintl"
          ];
          hyprgrass-bindm = [
            " , longpress:2, movewindow"
            " , longpress:3, resizewindow"
          ];
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
      # KWallet6 configuration
      env=KDE_FULL_SESSION,true
      env=KDE_SESSION_VERSION,6
      env=QT_QPA_PLATFORMTHEME,kde
      env=SSH_AUTH_SOCK,/run/user/1000/kwallet6.socket
      # env=HYPRCURSOR_THEME,phinger-cursors-light
      # env=GTK_THEME,Dracula
      env=HYPRCURSOR_SIZE,32
      # env=QT_QPA_PLATFORMTHEME,qt6ct

      # Screenshots
      bind = , PRINT, exec, grim -g "$(slurp)"

      # Begin Hyprscroller
      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      bind = $mainMod, home, scroller:movefocus, begin
      bind = $mainMod, end, scroller:movefocus, end

      # Movement
      bind = $mainMod SHIFT, left, movewindow, l
      bind = $mainMod SHIFT, right, movewindow, r
      bind = $mainMod SHIFT, up, movewindow, u
      bind = $mainMod SHIFT, down, movewindow, d
      bind = $mainMod SHIFT, home, scroller:movewindow, begin
      bind = $mainMod SHIFT, end, scroller:movewindow, end

      # Modes
      bind = $mainMod, bracketleft, exec, notify-send "Scroller Mode" "Row Mode Activated"
      bind = $mainMod, bracketleft, scroller:setmode, row
      bind = $mainMod, bracketright, exec, notify-send "Scroller Mode" "Column Mode Activated"
      bind = $mainMod, bracketright, scroller:setmode, col

      # Sizing keys
      # bind = $mainMod, equal, scroller:cyclesize, next
      # bind = $mainMod, minus, scroller:cyclesize, prev
      bind = $mainMod, equal, scroller:cyclewidth, next
      bind = $mainMod, minus, scroller:cyclewidth, prev
      bind = $mainMod SHIFT, equal, scroller:cycleheight, next
      bind = $mainMod SHIFT, minus, scroller:cycleheight, prev

      # Admit/Expel
      bind = $mainMod, I, scroller:admitwindow,
      bind = $mainMod, O, scroller:expelwindow,

      # Center submap
      # will switch to a submap called center
      bind = $mainMod, C, exec, notify-send "Scroller Submap" "Center Mode - Use C/M/arrows to align, ESC to exit"
      bind = $mainMod, C, submap, center
      # will start a submap called "center"
      submap = center
      # sets repeatable binds for resizing the active window
      bind = , C, scroller:alignwindow, c
      bind = , C, submap, reset
      bind = , m, scroller:alignwindow, m
      bind = , m, submap, reset
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
      bind = $mainMod SHIFT, R, exec, notify-send "Scroller Submap" "Resize Mode - Use arrows to resize, ESC to exit"
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
      bind = $mainMod, G, exec, notify-send "Scroller Submap" "Fit Size Mode - G/arrows to fit, ESC to exit"
      bind = $mainMod, G, submap, fitsize
      # will start a submap called "fitsize"
      submap = fitsize
      # sets binds for fitting columns/windows in the screen
      bind = , G, scroller:fitsize, visible
      bind = , G, submap, reset
      bind = , right, scroller:fitsize, toend
      bind = , right, submap, reset
      bind = , left, scroller:fitsize, tobeg
      bind = , left, submap, reset
      bind = , up, scroller:fitsize, active
      bind = , up, submap, reset
      bind = , down, scroller:fitsize, all
      bind = , down, submap, reset
      # bind = , bracketleft, scroller:fitwidth, all
      bind = , bracketleft, submap, reset
      # bind = , bracketright, scroller:fitheight, all
      bind = , bracketright, submap, reset
      # use reset to go back to the global submap
      bind = , escape, submap, reset
      # will reset the submap, meaning end the current one and return to the global one
      submap = reset

      # overview keys
      # bind key to toggle overview (normal)
      bind = $mainMod, grave, scroller:toggleoverview
      bind = ,mouse:275, scroller:toggleoverview

      # Marks
      bind = $mainMod, M, exec, notify-send "Scroller Submap" "Add Marks Mode - Use A/B/C to mark, ESC to exit"
      bind = $mainMod, M, submap, marksadd
      submap = marksadd
      bind = , a, scroller:marksadd, a
      bind = , a, submap, reset
      bind = , a, exec, notify-send "Marks" "Added mark A"
      bind = , b, scroller:marksadd, b
      bind = , b, submap, reset
      bind = , b, exec, notify-send "Marks" "Added mark B"
      bind = , c, scroller:marksadd, c
      bind = , c, submap, reset
      bind = , c, exec, notify-send "Marks" "Added mark C"
      bind = , escape, submap, reset
      submap = reset

      bind = $mainMod SHIFT, M, exec, notify-send "Scroller Submap" "Delete Marks Mode - Use A/B/C to delete, ESC to exit"
      bind = $mainMod SHIFT, M, submap, marksdelete
      submap = marksdelete
      bind = , a, scroller:marksdelete, a
      bind = , a, submap, reset
      bind = , a, exec, notify-send "Marks" "Deleted mark A"
      bind = , b, scroller:marksdelete, b
      bind = , b, submap, reset
      bind = , b, exec, notify-send "Marks" "Deleted mark B"
      bind = , c, scroller:marksdelete, c
      bind = , c, submap, reset
      bind = , c, exec, notify-send "Marks" "Deleted mark C"
      bind = , escape, submap, reset
      submap = reset

      bind = $mainMod, apostrophe, exec, notify-send "Scroller Submap" "Visit Marks Mode - Use A/B/C to visit, ESC to exit"
      bind = $mainMod, apostrophe, submap, marksvisit
      submap = marksvisit
      bind = , a, scroller:marksvisit, a
      bind = , a, submap, reset
      bind = , a, exec, notify-send "Marks" "Visited mark A"
      bind = , b, scroller:marksvisit, b
      bind = , b, submap, reset
      bind = , b, exec, notify-send "Marks" "Visited mark B"
      bind = , c, scroller:marksvisit, c
      bind = , c, submap, reset
      bind = , c, exec, notify-send "Marks" "Visited mark C"
      bind = , escape, submap, reset
      submap = reset

      bind = $mainMod CTRL, M, scroller:marksreset

      # Pin
      bind = $mainMod, P, scroller:pin,

      # Window copy/paste
      bind = $mainMod, Insert, scroller:selectiontoggle,
      bind = $mainMod CTRL, Insert, scroller:selectionreset,
      bind = $mainMod SHIFT, Insert, scroller:selectionmove, right
      # bind = $mainMod CTRL SHIFT, Insert, scroller:selectionworkspace,

      # Trails and Trailmarks
      bind = $mainMod SHIFT, semicolon, exec, notify-send "Scroller Submap" "Trail Mode - Use brackets to navigate, semicolon for new, ESC to exit"
      bind = $mainMod SHIFT, semicolon, submap, trail
      submap = trail
      bind = , bracketright, scroller:trailnext,
      bind = , bracketleft, scroller:trailprevious,
      bind = , semicolon, scroller:trailnew,
      bind = , semicolon, submap, reset
      bind = , d, scroller:traildelete,
      bind = , d, submap, reset
      bind = , c, scroller:trailclear,
      bind = , c, submap, reset
      bind = , Insert, scroller:trailtoselection,
      bind = , Insert, submap, reset
      bind = , escape, submap, reset
      submap = reset

      bind = $mainMod, semicolon, exec, notify-send "Scroller Submap" "Trail Mark Mode - Use brackets to navigate, semicolon to toggle, ESC to exit"
      bind = $mainMod, semicolon, submap, trailmark
      submap = trailmark
      bind = , bracketright, scroller:trailmarknext,
      bind = , bracketleft, scroller:trailmarkprevious,
      bind = , semicolon, scroller:trailmarktoggle,
      bind = , semicolon, submap, reset
      bind = , escape, submap, reset
      submap = reset

      bind = $mainMod, tab, scroller:jump,
      # End Hyprscroller
    '';
  };
}
