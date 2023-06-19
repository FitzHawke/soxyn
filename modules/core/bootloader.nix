{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];
  boot = {
    tmp.cleanOnBoot = true;
    bootspec.enable = true;
    consoleLogLevel = 4;
    initrd.systemd.enable = true;
    # switch from old kernel
    kernelPackages = lib.mkDefault pkgs.linuxPackages_xanmod_latest;
    # load modules on boot
    kernelModules = ["acpi_call"];

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 15;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
  };
  console.earlySetup = true;
}
