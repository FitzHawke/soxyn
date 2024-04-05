{
  inputs,
  pkgs,
  ...
}: let
  agsoxyn = pkgs.callPackage ./config {
    inherit inputs;
  };
in {
  imports = [inputs.ags.homeManagerModules.default];

  home.packages = with pkgs; [
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

  programs.ags = {
    enable = true;
  };
}
