{
  pkgs,
  config,
  ...
}: {
  stylix.icons = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    light = "Papirus";
    dark = "Papirus-Dark";
  };
  gtk.gtk4.theme = config.gtk.theme;
}
