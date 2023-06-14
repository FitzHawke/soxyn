{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./discord.nix
    ./element.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./keepassxc.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./qt.nix
    ./rnnoise.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    xdg-utils
  ];
}
