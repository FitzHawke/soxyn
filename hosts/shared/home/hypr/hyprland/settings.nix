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
      "col.active_border" = "rgb(89b4fa) rgb(cba6f7) 270deg";
      "col.inactive_border" = "rgb(11111b) rgb(b4befe) 270deg";
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
        color = "rgba(00000099)";
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

    group = {
      "col.border_active" = "rgb(f5c2e7)";
      "col.border_inactive" = "rgb(313244)";
    };

    misc = {
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      force_default_wallpaper = 0;
    };
  };
}
