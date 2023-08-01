{...}: let
  primary = ../../../assets/cherry-1.png;
in {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=${primary}

    wallpaper = DP-1,${primary}
  '';
}
