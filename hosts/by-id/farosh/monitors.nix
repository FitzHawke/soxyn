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
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      x = 1920;
      y = 0;
      workspace = "2";
      wallpaper = ../../../assets/firewatch-3-2.png;
    }
  ];
}
