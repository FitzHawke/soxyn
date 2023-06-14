{ config
, pkgs
, ...
}:
let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.root.initialPassword = "changeme";
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
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifExists [
      "docker"
      "podman"
      "git"
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
    initialPassword = "changeme";
    openssh.authorizedKeys.keys = [ (builtins.readFile ../../home/ssh.pub) ];
  };
}
