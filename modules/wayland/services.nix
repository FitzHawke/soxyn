{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";
        };
      };
    };

    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "lock";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        HibernateDelaySec=3600
      '';
    };
    printing.enable = true;
  };

  # unlock GPG keyring on login
  security.pam.services.greetd = {
        gnupg.enable = true;
        enableGnomeKeyring = true;
      };
}
