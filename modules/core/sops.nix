{inputs, config, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;

  sops.age = {
    sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    keyFile = "/var/lib/sops-nix/key.txt";
    generateKey = true;
  };

  sops.secrets.loc-lat.owner = config.users.users.will.name;
  sops.secrets.loc-long.owner = config.users.users.will.name;
}
