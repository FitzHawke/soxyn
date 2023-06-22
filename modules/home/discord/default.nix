{pkgs, ...}: let
  discord = pkgs.discord.override {
    nss = pkgs.nss_latest;
    withOpenASAR = true;
  };
in {
  home.packages = [
    discord
    pkgs.webcord
  ];

  xdg.configFile."WebCord/Themes/catppuccin".text = ''
    @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css");
  '';
}