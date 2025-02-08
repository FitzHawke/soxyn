{osConfig, ...}: {
  imports = [
    ./hyprland
    ./hypridle.nix
    ./hyprlock.nix
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
}
