{ config
, pkgs
,...
}: {
  imports = [
    # ./adblock.nix
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
