{
  pkgs,
  lib,
  ...
}: let
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    # only suspend if audio isn't running
    if [ $? == 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in {
  home.packages = [pkgs.hypridle];

  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
        lock_cmd = ${lib.getExe pkgs.hyprlock}
        before_sleep_cmd = ${pkgs.systemd}/bin/loginctl lock-session
    }

    # turn off screen after 5 minutes
    # disabled for testing suspend functionality
    # listener {
    #     timeout = 300
    #     on-timeout = hyprctl dispatch dpms off
    #     on-resume = hyprctl dispatch dpms on
    # }

    # suspend system after 15 minutes
    listener {
        timeout = 900
        on-timeout = ${suspendScript.outPath}
    }
  '';

  systemd.user.services.hypridle = {
    Unit = {
      Description = "Hypridle";
      After = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${lib.getExe pkgs.hypridle}";
      Restart = "always";
      RestartSec = "10";
    };

    Install.WantedBy = ["default.target"];
  };
}
