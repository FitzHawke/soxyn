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

  boot = {
    # switch kernel
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = [
      # potentially fixes a lockup on first-gen ryzen
      "processor.max_cstate=5"
    ];
    kernelModules = [ "rtw88" ];
  };

  services = {
    fwupd.enable = true;
    smartd.enable = true;
    thermald.enable = builtins.elem config.nixpkgs.system ["x86_64-linux"];
  };

  programs.gamemode.settings.gpu = {
    apply_gpu_optimisations = "accept-responsibility";
    gpu_device = 0;
    amd_performance_level = "high";
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
      device = "will@ruto.home.arpa:/mnt/hylia";
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
