{
  lib,
  config,
  osConfig,
  ...
}: {
  imports = [../../../../by-id/${osConfig.networking.hostName}/monitors.nix];

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = lib.map (m: "${m.wallpaper}") (config.monitors);
      wallpaper = lib.map (m: "${m.name},${m.wallpaper}") (config.monitors);
    };
  };

  # map through monitors and setup for hyprland config
  # outputs: "monitor=DP-1,1920x1080@60,0x0,1"

  wayland.windowManager.hyprland.settings = {
    monitor = lib.map (m: let
      resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
      position = "${toString m.x}x${toString m.y}";
    in "${m.name},${
      if m.enabled
      then "${resolution},${position},1"
      else "disable"
    }") (config.monitors);
  };

  wayland.windowManager.hyprland.extraConfig = config.extraHyprConf;
}
