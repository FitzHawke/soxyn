{...}: {
  wayland.windowManager.hyprland.settings = {
    animation = [
      "border, 1, 2, default"
      "fade, 1, 4, default"
      "windows, 1, 3, default, popin 80%"
      "workspaces, 1, 2, default, slide"
    ];

    windowrule = [
      # only shadow floating windows
      "no_shadow on, match:float off"

      # firefox PiP default floating and sticky
      "float on, match:title ^(Picture-in-Picture)$"
      "pin on, match:title ^(Picture-in-Picture)$"

      # throw sharing indicators away
      "workspace special silent, match:title ^(Firefox — Sharing Indicator)$"
      "workspace special silent, match:title ^(.*is sharing (your screen|a window)\.)$"

      # idle inhibit while watching videos
      "idle_inhibit focus, match:class ^(mpv|.+exe|celluloid)$"
      "idle_inhibit focus, match:class ^(firefox)$, match:title ^(.*YouTube.*)$"
      "idle_inhibit fullscreen, match:class ^(firefox)$"

      # idle inhibit fullscreen anything
      "idle_inhibit fullscreen, match:fullscreen_state_client 2"

      # dim around popups
      "dim_around on, match:class ^(gcr-prompter)$"
      "dim_around on, match:class ^(xdg-desktop-portal-gtk)$"
      "dim_around on, match:class ^(polkit-gnome-authentication-agent-1)$"

      # no rounding on xwayland
      "rounding 0, match:xwayland true, match:float on"
    ];
  };
}
