{pkgs, ...}: {
  home.packages = with pkgs; [
    chatterino2
    playerctl
    pavucontrol
    pulsemixer
    # imv uses insecure freeimage library. disable until update to 4.5.0 (pr# 290398)
    # imv 
  ];
  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      config.osc = false;
      scripts = with pkgs.mpvScripts; [
        mpris
        thumbnail
        sponsorblock
      ];
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [wlrobs];
    };
  };
  services.playerctld.enable = true;
}
