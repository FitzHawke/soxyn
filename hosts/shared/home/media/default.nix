{pkgs, ...}: {
  home.packages = with pkgs; [
    amberol
    celluloid
    loupe
    shortwave
    playerctl
    pavucontrol
    pulsemixer
  ];
  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [wlrobs];
    };
  };
}
