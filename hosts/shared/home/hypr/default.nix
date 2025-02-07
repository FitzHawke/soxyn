{
  pkgs,
  osConfig,
  ...
}: {
  imports = [
    ./hyprland
    ./hypridle.nix
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    grimblast # screenshots
    libnotify # notifications daemon
    wf-recorder # screen recording
    wl-clipboard # clipboard
    cliphist # clipboard history
  ];

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

  # add env file from agenix with WL_LATITUDE and WL_LONGITUDE
  systemd.user.services.wlsunset.Service = {
    EnvironmentFile = "${osConfig.age.secrets.wl-loc.path}";
  };

  # start a service to monitor clipboard history
  # only accessable through command line atm
  systemd.user.services.cliphist = {
    Unit.Description = "Clipboard history";
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "always";
    };
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
}
