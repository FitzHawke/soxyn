{inputs, config, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;

  # automatically generate age key to decrypt using the hosts ssh key
  sops.age = {
    sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    keyFile = "/var/lib/sops-nix/key.txt";
    generateKey = true;
  };

  # need to do this here outside of home manager for some reason
  sops.secrets.wl-location.owner = config.users.users.will.name;
}
