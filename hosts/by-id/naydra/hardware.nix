{
  pkgs,
  config,
  ...
}: {
  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
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
    "/mnt/disk1" = {
      device = "/dev/disk/by-uuid/44d11fea-626e-4877-a2a3-3f5b4ecc855c";
      fsType = "ext4";
    };
    "/mnt/disk2" = {
      device = "/dev/disk/by-uuid/5027dd00-f889-47a3-9505-ca28be3495d5";
      fsType = "ext4";
    };
    "/mnt/disk3" = {
      device = "/dev/disk/by-uuid/967783d9-f49e-4bca-9745-d213b08e2044";
      fsType = "ext4";
    };
    "/mnt/disk4" = {
      device = "/dev/disk/by-uuid/dbccc98d-82df-41ce-b19f-6a83b90009ad";
      fsType = "ext4";
    };
    "/mnt/disk5" = {
      device = "/dev/disk/by-uuid/fa8263da-c535-47c6-9886-230d717a7957";
      fsType = "ext4";
    };
    "/mnt/disk6" = {
      device = "/dev/disk/by-uuid/87098062-e6d2-4a65-a18e-6a124076ac0f";
      fsType = "ext4";
    };
    "/mnt/hylia" = {
      device = "/mnt/disk1:/mnt/disk2:/mnt/disk3:/mnt/disk4:/mnt/disk5:/mnt/disk6";
      fsType = "fuse.mergerfs";
      options = ["allow_other" "minfreespace=16G" "fsname=hylia"];
    };
    "/mnt/down" = {
      device = "192.168.2.3:/home/user/rtdown/completed";
      fsType = "nfs";
    };
  };
}
