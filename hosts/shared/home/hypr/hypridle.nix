{
  pkgs,
  lib,
  ...
}: let
  locktime = 600;
  lock = "${lib.getExe pkgs.hyprlock}";
  sleeptime = 900;
  suspend = "${pkgs.systemd}/bin/systemctl suspend";
in {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = lock;
      };

      listener = [
        {
          timeout = locktime;
          on-timeout = lock;
        }
        {
          timeout = sleeptime;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = sleeptime + 10;
          on-timeout = suspend;
        }
      ];
    };
  };
}
