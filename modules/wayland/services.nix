{
  lib,
  pkgs,
  config,
  ...
}: let
  greetdSwayConfig = pkgs.writeText "greetd-sway-config" ''
    exec "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"
    input "type:touchpad" {
      tap enabled
    }
    seat seat0 xcursor_theme Catppuccin-Mocha-Dark-Cursors 16

    xwayland disable

    bindsym XF86MonBrightnessUp exec brightnessctl set +5%
    bindsym XF86MonBrightnessDown exec brightnessctl set -5%
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'

    exec "${lib.getExe config.programs.regreet.package} -l debug; swaymsg exit"
  '';
in {
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = ../home/hyperland/wall.png;
        fit = "Cover";
      };
      GTK = {
        cursor_theme_name = "Catppuccin-Mocha-Dark-Cursors";
        font_name = "Lexend * 13";
        icon_theme_name = "cat-mocha-mauve";
        theme_name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      };
    };
  };

  services = {
    greetd = {
      enable = true;
      settings.default_session.command = "${config.programs.sway.package}/bin/sway --config ${greetdSwayConfig}";
    };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };
    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "lock";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        HibernateDelaySec=3600
      '';
    };

    lorri.enable = true;
    printing.enable = true;
    fstrim.enable = true;
  };
}
