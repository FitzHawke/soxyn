{...}: {
  imports = [
    ./network.nix
    ./nix.nix
    ./openssh.nix
    ./podman.nix
    ./security.nix
    ./sops.nix
    ./system.nix
    ./users.nix
  ];
}
