{...}: let
  primary = ../../../assets/firewatch-3-1.png;
  second = ../../../assets/firewatch-3-2.png;
in {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=${primary}
    preload=${second}

    wallpaper = DP-1,${primary}
    wallpaper = HDMI-A-1,${second}
  '';
}
