{...}: {
  imports = [
    ./network.nix
    ./nix.nix
    ./openssh.nix
    ./podman.nix
    ./security.nix
    ./sops.nix
    ./syncthing.nix
    ./system.nix
    ./users.nix
  ];
}
