{
  pkgs,
  config,
  ...
}: {
  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  boot = {
    # switch kernel
    kernelPackages = pkgs.linuxPackages_latest;
  };

  services = {
    fwupd.enable = true;
    smartd.enable = true;
    thermald.enable = builtins.elem config.nixpkgs.system ["x86_64-linux"];
  };

  system.fsPackages = [pkgs.sshfs];

  fileSystems."/".options = ["autodefrag" "compress=zstd" "discard=async"];
  fileSystems."/mnt/hylia" = {
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
}
