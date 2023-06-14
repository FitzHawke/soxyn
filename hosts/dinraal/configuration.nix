# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd
    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix
    ../common
    ../../users/user1
  ];

  services.greetd.settings.default_session.user = "will";

  networking =
    {
      hostName = "dinraal";
      useDHCP = true;
    };

  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  xdg.portal = { enable = true; };
  hardware =
    {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    };

  system.stateVersion = "23.05";
}
