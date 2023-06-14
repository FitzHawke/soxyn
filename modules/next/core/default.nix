{ config
, pkgs
, ...
}: {
  imports = [
    ./adblock.nix
    ./bootloader.nix
    ./cron.nix
    ./network.nix
    ./nix.nix
    ./openssh.nix
    ./podman.nix
    ./security.nix
    ./system.nix
    ./users.nix
  ];
}
