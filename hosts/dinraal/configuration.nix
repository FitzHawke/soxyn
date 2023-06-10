# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    ./hardware-configuration.nix

    ../common/core/bluetooth.nix
    ../common/core/efi-boot.nix
    ../common/core/fish.nix
    ../common/core/greetd.nix
    ../common/core/laptop.nix
    ../common/core/locale.nix
    ../common/core/nix.nix
    ../common/core/openssh.nix
    ../common/core/physical.nix
    ../common/core/pipewire.nix
    ../common/core/sops.nix
    ../common/core/steam-hardware.nix
    ../common/core/systemd-initrd.nix
    ../common/core/wireless.nix
  ];

  networking =
    {
      hostName = "dinraal";
      useDHCP = true;
    };

  xdg.portal = { enable = true; wlr.enable = true; };
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
