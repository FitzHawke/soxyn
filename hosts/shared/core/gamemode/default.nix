{...}: {
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "auto";
        inhibit_screensaver = 1;
        renice = 15;
      };
    };
  };
}
