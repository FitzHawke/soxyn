{
  inputs,
  pkgs,
  lib,
  config,
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

  systemd.user.services.agsoxyn = {
    Install = {
      WantedBy = [config.wayland.systemd.target];
    };

    Unit = {
      ConditionEnvironment = "WAYLAND_DISPLAY";
      Description = "agsoxyn desktop";
      After = [config.wayland.systemd.target];
      PartOf = [config.wayland.systemd.target];
    };

    Service = {
      ExecStart = "${lib.getExe agsoxyn}";
      ExecStop = "${lib.getExe agsoxyn} -q";
      Restart = "always";
      RestartSec = "10";
    };
  };
}
