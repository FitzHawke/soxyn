{pkgs, ...}: {
  home.packages = with pkgs; [
    amberol
    celluloid
    loupe
    shortwave
    playerctl
    pavucontrol
    pulsemixer
    vdhcoapp
  ];
  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [wlrobs];
    };
  };
}
