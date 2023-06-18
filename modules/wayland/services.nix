{config, lib,...}: {
  services = {
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${lib.getExe config.programs.hyprland.package}/bin/Hyperland";
        user = "will";
      };
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
