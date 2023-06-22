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
      driSupport32Bit = true;
    };
  };
  services = {
    fwupd.enable = true;
    smartd.enable = true;
    thermald.enable = builtins.elem config.nixpkgs.system ["x86_64-linux"];
  };

  system.fsPackages = [pkgs.sshfs];

  fileSystems = {
    "/".options = ["autodefrag" "compress=zstd" "discard=async"];
    "/home".options = ["autodefrag" "compress=zstd" "discard=async"];
    "/nix".options = ["autodefrag" "compress=zstd" "noatime" "discard=async"];
    "/mnt/scale" = {
      device = "/dev/disk/by-uuid/d517c9ec-70e8-49ec-9976-a04c995b81d6";
      fsType = "btrfs";
      options = ["autodefrag" "compress=zstd"];
    };
    "/mnt/shard" = {
      device = "/dev/disk/by-uuid/bdbda20c-3818-447d-ae69-5431d6596f08";
      fsType = "btrfs";
      options = ["autodefrag" "compress=zstd"];
    };
    "/mnt/hylia" = {
      device = "will@192.168.1.50:/mnt/hylia";
      fsType = "sshfs";
      options = [
        "allow_other"
        "idmap=user"
        "_netdev"
        "x-systemd.automount"
        "identityFile=/etc/ssh/ssh_host_ed25519_key"
        "ServerAliveInterval=15"
        "reconnect"
        "noatime"
      ];
    };
  };
}
