{
  inputs,
  stdenv,
  pkgs,
  ...
}: let
  name = "agsoxyn";
  src = ./config;
in
  inputs.ags.lib.bundle {
    inherit pkgs name src;
    entry = "${src}/app.ts";
    gtk4 = true;

    extraPackages =
      (with inputs.ags.packages.${stdenv.hostPlatform.system}; [
        apps
        astal4
        battery
        bluetooth
        hyprland
        mpris
        network
        notifd
        tray
        wireplumber
      ])
      ++ (with pkgs; [
        brightnessctl
        hyprpicker
      ]);
  }
