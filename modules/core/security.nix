{
  pkgs,
  lib,
  ...
}:
# this makes our system more secure
# note that it might break some stuff, eg webcam
{
  # tmpfs = /tmp is mounted in ram. Doing so makes temp file management speedy
  # on ssd systems, and volatile! Because it's wiped on reboot.
  boot.tmp.useTmpfs = lib.mkDefault true;
  # Firefox cache on tmpfs
  fileSystems."/home/will/.cache/mozilla/firefox" = {
    device = "tmpfs";
    fsType = "tmpfs";
    noCheck = true;
    options = [
      "noatime"
      "nodev"
      "nosuid"
      "size=128M"
    ];
  };
  programs.ssh.startAgent = true;
  security = {
    protectKernelImage = true;
    lockKernelModules = false;
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
    pam = {
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];
      services = {
        login.enableGnomeKeyring = true;
        swaylock = {
          text = ''
            auth include login
          '';
        };
      };
    };

    doas = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          persist = true;
          keepEnv = false;
        }
        {
          groups = ["power"];
          noPass = true;
          cmd = "${pkgs.systemd}/bin/poweroff";
        }
        {
          groups = ["power"];
          noPass = true;
          cmd = "${pkgs.systemd}/bin/reboot";
        }
        {
          groups = ["nix"];
          cmd = "nix-collect-garbage";
          noPass = true;
        }
        {
          groups = ["nix"];
          cmd = "nixos-rebuild";
          keepEnv = true;
        }
      ];
    };
    sudo.enable = false;
  };

  # Security
  boot.blacklistedKernelModules = [
    # Obscure network protocols
    "ax25"
    "netrom"
    "rose"
    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "vivid"
    "gfs2"
    "ksmbd"
    "nfsv4"
    "nfsv3"
    "cifs"
    "nfs"
    "cramfs"
    "freevxfs"
    "jffs2"
    "hfs"
    "hfsplus"
    "squashfs"
    "udf"
    "bluetooth"
    "btusb"
    "uvcvideo" # thats why your webcam not worky
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "omfs"
    "uvcvideo"
    "qnx4"
    "qnx6"
    "sysv"
  ];
}
