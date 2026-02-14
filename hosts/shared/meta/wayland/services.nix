{
  lib,
  config,
  pkgs,
  ...
}: {
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd}/bin/agreety --cmd '${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop'";
        };
      };
    };

    logind.settings.Login = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "lock";
    };

    # printing setup for modern printers (ipp)
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  # unlock GPG keyring on login
  security.pam.services.greetd = {
    gnupg.enable = true;
    enableGnomeKeyring = true;
  };
}
