{pkgs, ...}: {
  stylix.iconTheme = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    light = "Papirus";
    dark = "Papirus-Dark";
  };
}
