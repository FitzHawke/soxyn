{
  config,
  pkgs,
  ...
}: let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
  };

  users.users.will = {
    isNormalUser = true;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ ifExists [
        "docker"
        "podman"
        "git"
        "syncthing"
        "libvirtd"
        "i2c"
        "systemd-journal"
        "plugdev"
        "wireshark"
        "input"
        "lp"
        "networkmanager"
        "power"
        "nix"
      ];
    uid = 1000;
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [(builtins.readFile ../../secrets/pubkeys/ssh.pub)];
  };
}
