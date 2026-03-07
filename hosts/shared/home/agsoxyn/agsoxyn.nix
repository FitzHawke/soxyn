{
  inputs,
  stdenv,
  pkgs,
  ...
}: let
  name = "agsoxyn";
  src = ./config;
in
  pkgs.stdenv.mkDerivation {
    pname = name;
    meta.mainProgram = name;
    inherit src name;
    version = "0.0.0";

    nativeBuildInputs = with pkgs; [
      wrapGAppsHook4
      gobject-introspection
      inputs.ags.packages.${stdenv.hostPlatform.system}.default
    ];

    buildInputs =
      (with inputs.ags.packages.${stdenv.hostPlatform.system}; [
        apps
        astal4
        battery
        bluetooth
        hyprland
        io
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

    installPhase = ''
      mkdir -p $out/bin
      ags bundle app.tsx $out/bin/agsoxyn
    '';
  }
