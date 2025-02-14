{
  inputs,
  system,
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
      (with inputs.ags.packages.${system}; [
        apps
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
