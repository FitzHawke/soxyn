{ ... }: {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload=${./primary.png}

      wallpaper = DP-1,${./primary.png}
    '';
}