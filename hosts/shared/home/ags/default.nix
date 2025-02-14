{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  agsoxynleg = pkgs.callPackage ./config {
    inherit inputs;
  };
in {
  home.packages = with pkgs; [
    agsoxynleg
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

  systemd.user.services.agsoxyn-leg = {
    Install = {
      WantedBy = [config.wayland.systemd.target];
    };

    Unit = {
      ConditionEnvironment = "WAYLAND_DISPLAY";
      Description = "agsoxyn legacy desktop";
      After = [config.wayland.systemd.target];
      PartOf = [config.wayland.systemd.target];
    };

    Service = {
      ExecStart = "${lib.getExe agsoxynleg}";
      ExecStop = "${lib.getExe agsoxynleg} -q";
      Restart = "always";
      RestartSec = "10";
    };
  };
}
