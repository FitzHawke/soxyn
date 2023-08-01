{...}: let
  primary = ../../../assets/cherry-1.png;
  second = ../../../assets/cherry-2.png;
in {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=${primary}
    preload=${second}

    wallpaper = DP-1,${primary}
    wallpaper = HDMI-A-1,${second}
  '';
}
