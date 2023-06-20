{pkgs, config, ...}: {
  hardware = {
  enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };
  };
  services = {
    fwupd.enable = true;
    smartd.enable = true;
    thermald.enable = builtins.elem config.nixpkgs.system ["x86_64-linux"];
  };
  fileSystems."/".options = ["autodefrag" "compress=zstd" "discard=async"];
}
