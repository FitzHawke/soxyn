{pkgs, config, ...}: {
  hardware = {
  enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
  services = {
    fwupd.enable = true;
    smartd.enable = true;
    thermald.enable = builtins.elem config.nixpkgs.system ["x86_64-linux"];
  };
}
