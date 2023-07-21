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

  system.fsPackages = [pkgs.sshfs];

  fileSystems."/".options = ["autodefrag" "compress=zstd" "discard=async"];
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
}
