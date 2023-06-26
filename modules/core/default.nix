{...}: {
  imports = [
    ./network.nix
    ./nix.nix
    ./openssh.nix
    ./podman.nix
    ./security.nix
    ./syncthing.nix
    ./system.nix
    ./users.nix
  ];
}
