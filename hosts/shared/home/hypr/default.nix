{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland
    ./hypridle.nix
    ./hyprlock.nix
  ];

  # wlsenset module doesn't like env vars anymore :(
  # so we just write our own sysd file for it now
  # with env file from agenix for WL_LATITUDE and WL_LONGITUDE
  systemd.user.services.wlsunset = {
    Unit = {
      Description = "Day/night gamma adjustments for Wayland compositors.";
      After = [config.wayland.systemd.target];
      PartOf = [config.wayland.systemd.target];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.wlsunset} -t3750 -T6200 -g1.00000 -L $WL_LONGITUDE -l $WL_LATITUDE";
      EnvironmentFile = "${osConfig.age.secrets.wl-loc.path}";
    };
    Install = {
      WantedBy = [config.wayland.systemd.target];
    };
  };
}
