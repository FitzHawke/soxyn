{ pkgs, config, ... }:
let ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = false;
  users.users.fitz = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "video" "audio" ] ++ ifExists [ "network" "i2c" "docker" "podman" "git" "libvirtd" ];

    openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/fitz/ssh.pub) ];
    passwordFile = config.sops.secrets.misterio-password.path;
    packages = [ pkgs.home-manager ];
  };

  sops.secrets.misterio-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.misterio = import ../../../../home/misterio/${config.networking.hostName}.nix;

  services.geoclue2.enable = true;
  security.pam.services = { swaylock = { }; };
}
