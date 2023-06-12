{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./discord.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./pavucontrol.nix
    ./rnnoise.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    xdg-utils-spawn-terminal
  ];
}
