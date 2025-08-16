{
  writeShellScript,
  stdenv,
  esbuild,
  dart-sass,
  fd,
  fzf,
  brightnessctl,
  slurp,
  wf-recorder,
  wl-clipboard,
  wayshot,
  swappy,
  hyprland,
  hyprpicker,
  pavucontrol,
  networkmanager,
  gtk3,
  libdbusmenu-gtk3,
  which,
  ags_1,
}: let
  name = "agsoxynleg";

  ags = ags_1.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ [libdbusmenu-gtk3];
  });

  dependencies = [
    which
    dart-sass
    fd
    fzf
    brightnessctl
    hyprland
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    gtk3
  ];

  addBins = list: builtins.concatStringsSep ":" (builtins.map (p: "${p}/bin") list);

  desktop = writeShellScript name ''
    export PATH=$PATH:${addBins dependencies}
    ${ags}/bin/ags -b ${name} -c ${config}/config.js $@
  '';

  config = stdenv.mkDerivation {
    inherit name;
    src = ./.;

    buildPhase = ''
      ${esbuild}/bin/esbuild \
        --bundle ./main.ts \
        --outfile=main.js \
        --format=esm \
        --external:resource://\* \
        --external:gi://\* \
    '';

    installPhase = ''
      mkdir -p $out
      cp -r assets $out
      cp -r style $out
      cp -r widget $out
      cp -f main.js $out/config.js
    '';
  };
in
  stdenv.mkDerivation {
    inherit name;
    meta.mainProgram = name;
    src = config;

    installPhase = ''
      mkdir -p $out/bin
      cp -r . $out
      cp ${desktop} $out/bin/${name}
    '';
  }
