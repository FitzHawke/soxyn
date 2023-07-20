{
  pkgs,
  lib,
  inputs,
  osConfig,
  ...
}: {
  imports = [./config.nix ../eww ../../../hosts/${osConfig.networking.hostName}/wallpaper.nix];
  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast # screenshots
    hyprpaper # wallpaper
    libnotify # notifications daemon
    wf-recorder # screen recording
    brillo # brightness
    pamixer # cli volume adjustment
    wl-clipboard # clipboard
    cliphist # clipboard history
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
  };

  services.wlsunset = {
    enable = true;
    # these values end up in systemd startup script so we read them from the environment
    latitude = "\$WL_LATITUDE";
    longitude = "\$WL_LONGITUDE";
    temperature = {
      day = 6200;
      night = 3750;
    };
  };

  # add env file from sops with WL_LATITUDE and WL_LONGITUDE
  systemd.user.services.wlsunset.Service = {
    EnvironmentFile = "${osConfig.age.secrets.wl-loc.path}";
  };

  # start a service to monitor clipboard history
  # only accessable through command line atm
  systemd.user.services.cliphist = {
    Unit.Description = "Clipboard history";
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getExe pkgs.cliphist} store";
      Restart = "always";
    };
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
}
