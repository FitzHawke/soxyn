{pkgs, ...}: let
  discord = pkgs.discord.override {
    nss = pkgs.nss_latest;
    withOpenASAR = true;
  };
in {
  home.packages = [
    pkgs.webcord
    discord
  ];
}
