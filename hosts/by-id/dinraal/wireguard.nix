{config, ...}: {
  # WARNING: this is untested
  # wireguard uses systemd, so to add extra secrets we can use systemd env files!
  systemd.services.wg0.Service.EnvironmentFile = "${config.age.secrets."wireguard/dinraal-env".path}";

  age.secrets = {
    "wireguard/dinraal-env".file = ../../../secrets/wireguard/dinraal-env.age;
    "wireguard/dinraal-key".file = ../../../secrets/wireguard/dinraal-key.age;
    };

  networking.firewall = {
    allowedUDPPorts = [51820];
  };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["$\WG_IPS"];
      listenPort = 51820;
      privateKeyFile = "${config.age.secrets."wireguard/dinraal-key".path}";
      peers = [
        {
          publicKey = "\$WG_PEER1_KEY";
          allowedIPs = ["\$WG_PEER1_ALLOWEDIPS"];
          endpoint = "\$WG_PEER1_ENDPOINT:\$WG_PEER1_PORT";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
