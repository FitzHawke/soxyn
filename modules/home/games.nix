{
  pkgs,
  inputs,
  ...
}: let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs: with pkgs; [
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
    ];
  };
in {
  home.packages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.system}.proton-ge
    bottles
    gamescope
    mangohud
    ryujinx
    steam-with-pkgs
    wineWowPackages.wayland
    yuzu
  ];
}
