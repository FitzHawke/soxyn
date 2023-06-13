{ pkgs, config, ... }:
let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = true;
  users.users.will = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "video" "audio" ] ++ ifExists [ "network" "i2c" "docker" "podman" "git" "libvirtd" ];

    openssh.authorizedKeys.keys = [ (builtins.readFile ../../home/ssh.pub) ];
    passwordFile = config.sops.secrets.user1-password.path;
    packages = [ pkgs.home-manager ];
  };

  sops.secrets = {
    sopsFile = ../../secrets.yaml;
    user1-password = { neededForUsers = true; };
  };

  home-manager.users.will = import ../../../../home/will/${config.networking.hostName}.nix;

  services.geoclue2.enable = true;
  security.pam.services = { swaylock = { }; };
}
