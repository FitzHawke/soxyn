{
  inputs,
  system,
  pkgs,
  ...
}: let
  name = "agsoxyn";
  src = ./config;
  ags = inputs.ags.packages.${system}.default;
in
  pkgs.stdenvNoCC.mkDerivation {
    inherit name src;
    meta.mainProgram = name;

    nativeBuildInputs = [
      ags
      pkgs.wrapGAppsHook
      pkgs.gobject-introspection
    ];

    buildInputs = with inputs.astral.packages.${system}; [
      astral4
      io
    ];

    installPhase = ''
      mkdir -p $out/bin
      ags bundle ${src}/app.ts $out/bin/${name}
    '';
  }
