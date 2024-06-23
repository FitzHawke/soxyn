{pkgs, ...}: {
  home.packages = with pkgs; [
    chatterino2
    playerctl
    pavucontrol
    pulsemixer
    imv 
    vdhcoapp
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
