{
  osConfig,
  config,
  ...
}: {
  # extraConfig =
  #      (import ./moniters.nix {
  #        inherit lib;
  #        inherit (config) monitors;
  #      }) +
  wayland.windowManager.hyprland.extraConfig =
    builtins.readFile ../../../hosts/${osConfig.networking.hostName}/hyprland.txt
    + ''
      $mod = SUPER

      # startup programs alongside hyprland
      exec-once = dbus-update-activation-environment --systemd --all
      exec-once = hyprpaper
      exec-once = mako
      exec-once = eww daemon && eww open bar

      input {
        kb_layout = us
        kb_options = caps:escape_shifted_capslock
        accel_profile = flat
        follow_mouse = 1
        touchpad {
          natural_scroll = true
          clickfinger_behavior = true
          tap-to-click = false
        }
      }

      general {
        gaps_in = 5
        gaps_out = 10
        border_size = 2
        col.active_border = rgb(89b4fa) rgb(cba6f7) 270deg
        col.inactive_border = rgb(11111b) rgb(b4befe) 270deg

        col.group_border = rgb(313244)
        col.group_border_active = rgb(f5c2e7)
      }

      misc {
        mouse_move_enables_dpms = true
        key_press_enables_dpms = true
        enable_swallow = true
        swallow_regex=(kitty|Nautilus)
      }

      decoration {
        active_opacity=0.96
        inactive_opacity=0.85
        fullscreen_opacity=1.0
        rounding = 16
        multisample_edges = true
        blur_new_optimizations = true
        blur = true
        blur_size = 3
        blur_passes = 3

        drop_shadow = true
        shadow_ignore_window = true
        shadow_offset = 0 5
        shadow_range = 50
        shadow_render_power = 3
        col.shadow = rgba(00000099)
      }

      animations {
        enabled = true
        animation = border, 1, 2, default
        animation = fade, 1, 4, default
        animation = windows, 1, 3, default, popin 80%
        animation = workspaces, 1, 2, default, slide
      }

      dwindle {
        pseudotile = false
        preserve_split = true
        no_gaps_when_only = false
      }

      gestures {
        workspace_swipe = yes
        workspace_swipe_forever = true
      }

      # only allow shadows for floating windows
      windowrulev2 = noshadow, floating:0

      # make Firefox PiP window floating and sticky
      windowrulev2 = float, title:^(Picture-in-Picture)$
      windowrulev2 = pin, title:^(Picture-in-Picture)$

      # throw sharing indicators away
      windowrulev2 = workspace special silent, title:^(Firefox — Sharing Indicator)$
      windowrulev2 = workspace special silent, title:^(.*is sharing (your screen|a window)\.)$

      # start Discord/WebCord in ws2
      windowrulev2 = workspace 2, title:^(.*(Disc|WebC)ord.*)$

      # idle inhibit while watching videos
      windowrulev2 = idleinhibit focus, class:^(mpv|.+exe)$
      windowrulev2 = idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$
      windowrulev2 = idleinhibit fullscreen, class:^(firefox)$
      windowrulev2 = idleinhibit focus, class:(jellyfin)
      windowrulev2 = idleinhibit fullscreen, class:(jellyfin)

      windowrulev2 = dimaround, class:^(gcr-prompter)$

      # fix xwayland apps
      windowrulev2 = rounding 0, xwayland:1, floating:1
      windowrulev2 = center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$
      windowrulev2 = size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$

      layerrule = blur, ^(gtk-layer-shell|anyrun)$
      layerrule = ignorezero, ^(gtk-layer-shell|anyrun)$

      # media controls
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous
      bindl = , XF86AudioNext, exec, playerctl next

      # volume
      bindle = , XF86AudioRaiseVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%+
      binde = , XF86AudioRaiseVolume, exec, ${config.home.homeDirectory}/.config/eww/scripts/volume osd
      bindle = , XF86AudioLowerVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%-
      binde = , XF86AudioLowerVolume, exec, ${config.home.homeDirectory}/.config/eww/scripts/volume osd
      bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = , XF86AudioMute, exec, ${config.home.homeDirectory}/.config/eww/scripts/volume osd
      bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

      # backlight
      bindle = , XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5
      binde = , XF86MonBrightnessUp, exec, ${config.home.homeDirectory}/.config/eww/scripts/brightness osd
      bindle = , XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5
      binde = , XF86MonBrightnessDown, exec, ${config.home.homeDirectory}/.config/eww/scripts/brightness osd

      # mouse movements
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow
      bindm = $mod ALT, mouse:272, resizewindow
      bind = $mod, mouse_down, workspace, e+1
      bind = $mod, mouse_up, workspace, e-1

      # compositor commands
      bind = $mod SHIFT, E, exec, pkill Hyprland
      bind = $mod, Q, killactive,
      bind = $mod, F, fullscreen,
      bind = $mod, G, togglegroup,
      bind = $mod SHIFT, N, changegroupactive, f
      bind = $mod SHIFT, P, changegroupactive, b
      bind = $mod, R, togglesplit,
      bind = $mod, T, togglefloating,
      bind = $mod, P, pseudo,
      bind = $mod ALT, ,resizeactive,
      # toggle "monocle" (no_gaps_when_only)
      $kw = dwindle:no_gaps_when_only
      bind = $mod, M, exec, hyprctl keyword $kw $(($(hyprctl getoption $kw -j | jaq -r '.int') ^ 1))

      # utility commands
      # launcher
      bindr = $mod, SUPER_L, exec, anyrun
      # terminal
      bind = $mod, Return, exec, kitty
      # logout menu
      bind = $mod, Escape, exec, wlogout -p layer-shell
      # lock screen
      bind = $mod SHIFT, L, exec, loginctl lock-session
      # browser
      bind = $mod, B, exec, firefox
      # file manager
      bind = $mod, E, exec, nautilus

      # move focus
      bind = $mod, left, movefocus, l
      bind = $mod, right, movefocus, r
      bind = $mod, up, movefocus, u
      bind = $mod, down, movefocus, d

      # move focus with vim
      bind = $mod, h, movefocus, l
      bind = $mod, l, movefocus, r
      bind = $mod, k, movefocus, u
      bind = $mod, j, movefocus, d

      # move between workspaces
      bind = $mod, 1, workspace, 1
      bind = $mod, 2, workspace, 2
      bind = $mod, 3, workspace, 3
      bind = $mod, 4, workspace, 4
      bind = $mod, 5, workspace, 5
      bind = $mod, 6, workspace, 6
      bind = $mod, 7, workspace, 7
      bind = $mod, 8, workspace, 8
      bind = $mod, 9, workspace, 9
      bind = $mod, 0, workspace, 10

      # move windows between workspaces
      bind = $mod SHIFT, 1, movetoworkspace, 1
      bind = $mod SHIFT, 2, movetoworkspace, 2
      bind = $mod SHIFT, 3, movetoworkspace, 3
      bind = $mod SHIFT, 4, movetoworkspace, 4
      bind = $mod SHIFT, 5, movetoworkspace, 5
      bind = $mod SHIFT, 6, movetoworkspace, 6
      bind = $mod SHIFT, 7, movetoworkspace, 7
      bind = $mod SHIFT, 8, movetoworkspace, 8
      bind = $mod SHIFT, 9, movetoworkspace, 9
      bind = $mod SHIFT, 0, movetoworkspace, 10
      bind = $mod SHIFT, right, movetoworkspace, +1
      bind = $mod SHIFT, left, movetoworkspace, -1

      # window resize
      binde = $mod ALT, L, resizeactive, 80 0
      binde = $mod ALT, H, resizeactive, -80 0
      bind = $mod, S, submap, resize

      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      binde = , l, resizeactive, 10 0
      binde = , h, resizeactive, -10 0
      binde = , k, resizeactive, 0 -10
      binde = , j, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset

      # screenshot
      # stop animations while screenshotting; makes black border go away
      $screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copysave area; hyprctl keyword animation "fadeOut,1,4,default"

      bind = , Print, exec, $screenshotarea
      bind = $mod SHIFT, R, exec, $screenshotarea

      bind = CTRL, Print, exec, grimblast --notify --cursor copysave output
      bind = $mod SHIFT CTRL, R, exec, grimblast --notify --cursor copysave output

      bind = ALT, Print, exec, grimblast --notify --cursor copysave screen
      bind = $mod SHIFT ALT, R, exec, grimblast --notify --cursor copysave screen

      # special workspace
      bind = $mod SHIFT, grave, movetoworkspace, special
      bind = $mod, grave, togglespecialworkspace, eDP-1

      # cycle workspaces
      bind = $mod, bracketleft, workspace, m-1
      bind = $mod, bracketright, workspace, m+1

      # cycle monitors
      bind = $mod SHIFT, braceleft, focusmonitor, l
      bind = $mod SHIFT, braceright, focusmonitor, r
    '';
}
