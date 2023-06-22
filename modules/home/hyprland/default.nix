{
  pkgs,
  lib,
  inputs,
  osConfig,
  ...
}:
with lib; let
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
in {
  imports = [./config.nix ../eww ../../../hosts/${osConfig.networking.hostName}/wallpaper.nix ];
  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast
    hyprpaper
    libnotify
    wf-recorder
    brillo
    pamixer
    python39Packages.requests
    slurp
    swappy
    wl-clipboard
    pngquant
    cliphist
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
  };

  services.wlsunset = {
    enable = true;
    latitude = "43.95";
    longitude = "-81.22";
    temperature = {
      day = 6200;
      night = 3750;
    };
  };

  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  # systemd.user.targets.tray = {
  #   Unit = {
  #     Description = "Home Manager System Tray";
  #     Requires = ["graphical-session-pre.target"];
  #   };
  # };

  systemd.user.services = {
    cliphist = mkService {
      Unit.Description = "Clipboard history";
      Service = {
        ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getExe pkgs.cliphist} store";
        Restart = "always";
      };
    };
  };
}
