{...}: {
  imports = [../../../modules/home/monitors.nix];
  monitors = [
    {
      name = "eDP-1";
      primary = true;
      width = 1920;
      height = 1080;
      refreshRate = 60;
      x = 0;
      y = 0;
      workspace = "1";
      wallpaper = ../../../assets/beach-1.png;
    }
  ];
}
