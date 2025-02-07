{...}: {
  imports = [../../../modules/home/monitors.nix];
  monitors = [
    {
      name = "DP-1";
      primary = true;
      width = 1920;
      height = 1080;
      refreshRate = 60;
      x = 0;
      y = 0;
      workspace = "1";
      wallpaper = ../../../assets/firewatch-3-1.png;
    }
    {
      name = "DP-3";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      x = 1920;
      y = 0;
      workspace = "2";
      wallpaper = ../../../assets/firewatch-3-2.png;
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      x = 960;
      y = -1080;
      workspace = "3";
      wallpaper = ../../../assets/cherry-2.png;
      enabled = false;
    }
  ];
  # Keybinds to enable/disable third monitor as needed
  extraHyprConf = ''

    # enable/disable third monitor
    bind = $mod, m, exec, hyprctl keyword monitor "HDMI-A-1, 1920x1080, 960x-1080, 1"
    bind = $mod SHIFT, m, exec, hyprctl keyword monitor "HDMI-A-1, disabled"
  '';
}
