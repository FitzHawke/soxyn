{pkgs, ...}: {
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
        HandlePowerKey=suspend
      '';
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
