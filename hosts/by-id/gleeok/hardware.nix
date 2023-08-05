{
  pkgs,
  config,
  ...
}: {
  hardware = {
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  system.fsPackages = [pkgs.mergerfs];

  services = {
    fwupd.enable = true;
    smartd.enable = true;
    thermald.enable = builtins.elem config.nixpkgs.system ["x86_64-linux"];
  };

  fileSystems = {
    "/".options = ["autodefrag" "compress=zstd" "discard=async"];
    "/home".options = ["autodefrag" "compress=zstd" "discard=async"];
    "/nix".options = ["autodefrag" "compress=zstd" "noatime" "discard=async"];
  };
}
