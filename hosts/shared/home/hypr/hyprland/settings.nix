{...}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "uwsm finalize"
      "hyprctl setcursor Bibata-Modern-Classic-Hyprcursor 16"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
    };

    decoration = {
      rounding = 12;
      active_opacity = 0.98;
      inactive_opacity = 0.9;
      fullscreen_opacity = 1.0;

      blur = {
        size = 3;
        passes = 3;
      };

      shadow = {
        range = 50;
        offset = "0 5";
      };
    };

    input = {
      kb_layout = "us";
      kb_options = "caps:escape_shifted_capslock";
      accel_profile = "flat";
      numlock_by_default = true;
      follow_mouse = 2;
      mouse_refocus = false;
      float_switch_override_focus = 0;
      touchpad = {
        natural_scroll = true;
        clickfinger_behavior = true;
        tap-to-click = false;
      };
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    misc = {
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      force_default_wallpaper = 0;
    };
  };
}
