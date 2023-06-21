{
  config,
  lib,
  ...
}: {
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  services = {
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${lib.getExe config.programs.hyprland.package}";
        user = "will";
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

    lorri.enable = true;
    printing.enable = true;
  };
}
