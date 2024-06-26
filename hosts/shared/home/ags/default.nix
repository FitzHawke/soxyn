{
  inputs,
  pkgs,
  ...
}: let
  agsoxyn = pkgs.callPackage ./config {
    inherit inputs;
  };
in {
  home.packages = with pkgs; [
    inputs.ags.packages.${system}.default
    agsoxyn
    bun
    dart-sass
    fd
    brightnessctl
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
}
