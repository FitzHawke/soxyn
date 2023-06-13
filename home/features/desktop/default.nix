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
    ./rnnoise.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    xdg-utils-spawn-terminal
  ];
}
