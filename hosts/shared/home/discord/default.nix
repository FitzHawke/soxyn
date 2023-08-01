{pkgs, ...}: {
  home.packages = [
    pkgs.webcord
  ];

  xdg.configFile."WebCord/Themes/catppuccin".text = ''
    @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css");
  '';
}