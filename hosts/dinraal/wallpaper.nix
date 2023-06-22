{ ... }: {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload=${./primary.png}

      wallpaper = eDP-1,${./primary.png}
    '';
}