{pkgs, ...}: {
  home.packages = with pkgs; [
    amberol
    celluloid
    chatterino2
    loupe
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
  services.playerctld.enable = true;
}
