{ ... }: {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload=${./primary.png}
      preload=${./secondary.png}

      wallpaper = DP-1,${./primary.png}
      wallpaper = HDMI-A-1,${./secondary.png}
    '';
}