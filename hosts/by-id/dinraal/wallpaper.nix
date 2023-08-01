{...}: let
  primary = ../../../assets/beach-1.png;
in {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=${primary}

    wallpaper = eDP-1,${primary}
  '';
}
