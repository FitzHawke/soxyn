{...}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bindm = [
      # resize and move windows with mouse
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    bindl = [
      # control media with dedicated keys
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"
    ];

    bindle = [
      # audio volume/mute with dedicated keys
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      # backlight with dedicated keys
      ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
      ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
    ];

    bindr = [
      "$mod, SUPER_L, exec, agsoxyn -t launcher"
    ];

    bind = [
      # scroll to change workspace
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      # compositor commands
      "$mod SHIFT, E, exec, pkill Hyprland"
      "$mod, Q, killactive,"
      "$mod, F, fullscreen,"
      "$mod, G, togglegroup,"
      "$mod SHIFT, N, changegroupactive, f"
      "$mod SHIFT, P, changegroupactive, b"
      "$mod, R, togglesplit,"
      "$mod, T, togglefloating,"
      "$mod, P, pseudo,"
      "$mod ALT, ,resizeactive,"

      # utility
      # terminal
      "$mod, Return, exec, foot"
      # logout menu
      "$mod, Escape, exec, agsoxyn -t powermenu"
      # lock screen
      "$mod SHIFT, L, exec, hyprlock"
      # calculator
      ", XF86Calculator, exec, gnome-calculator"
      # settings
      "$mod, U, exec, XDG_CURRENT_DESKTOP=gnome gnome-control-center"
      # browser
      "$mod, B, exec, firefox"
      # file manager
      "$mod, E, exec, nautilus"

      # move focus
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      # switch workspace
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      # move window to new workspace
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"
      "$mod SHIFT, right, movetoworkspace, +1"
      "$mod SHIFT, left, movetoworkspace, -1"

      # screenshot
      ", Print, exec, grimblast --notify copysave area"
      "CTRL, Print, exec, grimblast --notify --cursor copysave output"
      "ALT, Print, exec, grimblast --notify --cursor copysave screen"

      # cycle workspaces
      "$mod, bracketleft, workspace, m-1"
      "$mod, bracketright, workspace, m+1"

      # cycle monitors
      "$mod SHIFT, bracketleft, focusmonitor, l"
      "$mod SHIFT, bracketright, focusmonitor, r"

      # send focused workspace to left/right monitors
      "$mod SHIFT ALT, bracketleft, movecurrentworkspacetomonitor, l"
      "$mod SHIFT ALT, bracketright, movecurrentworkspacetomonitor, r"
    ];
  };
}
