{
  # lib,
  # config,
  # pkgs,
  ...
}: {
  #  let
  #   addSecretsToConfig =
  #     pkgs.writeShellScriptBin "addSecretsToConfig" ''
  #       dinraal=$(cat /run/agenix/din)
  #       naydra=$(cat /run/agenix/nay)
  #       gleeok=$(cat /run/agenix/glee)
  #       riju=$(cat /run/agenix/riju)
  #       webpass=$(cat /run/agenix/st-webpass)

  #       config="/home/will/.config/syncthing"

  #       sed -i 's/ST_DINRAAL_KEY/$dinraal/g' $config
  #       sed -i 's/ST_NAYDRA_KEY/$naydra/g' $config
  #       sed -i 's/ST_GLEEOK_KEY/$gleeok/g' $config
  #       sed -i 's/ST_RIJU_KEY/$riju/g' $config
  #       sed -i 's/ST_WEB_PASS/$webpass/g' $config
  #     '';
  # in {
  services.syncthing = {
    enable = true;
    user = "will";
    dataDir = "/home/will/sync"; # Default folder for new synced folders
    configDir = "/home/will/.config/syncthing"; # Folder for Syncthing's settings and keys

    # overrideDevices = true; # overrides any devices added or deleted through the WebUI
    # overrideFolders = true; # overrides any folders added or deleted through the WebUI
    # guiAddress = "0.0.0.0:8384";
    # devices = {
    #   "dinraal" = {id = "\$ST_DINRAAL_KEY";};
    #   "naydra" = {id = "\$ST_NAYDRA_KEY";};
    #   "gleeok" = {id = "\$ST_GLEEOK_KEY";};
    #   "riju" = {id = "\$ST_RIJU_KEY";};
    # };
    # folders = {
    #   "base" = {
    #     # Name of folder in Syncthing, also the folder ID
    #     path = "/home/will/sync/base"; # Which folder to add to Syncthing
    #     devices = ["dinraal" "naydra" "gleeok" "riju"]; # Which devices to share the folder with
    #   };
    #   "flood" = {
    #     path = "/home/will/sync/flood";
    #     devices = ["dinraal" "naydra" "gleeok"];
    #   };
    # };
    # extraOptions.gui = {
    #   user = "fitzhawke";
    #   password = "\$ST_WEB_PASS";
    # };
  };

  # # add env files from agenix with secrets
  # systemd.services.syncthing-init.serviceConfig.EnvironmentFile = [
  #   "${config.age.secrets.din.path}"
  #   "${config.age.secrets.glee.path}"
  #   "${config.age.secrets.nay.path}"
  #   "${config.age.secrets.riju.path}"
  #   "${config.age.secrets.st-webpass.path}"
  # ];

  # age.secrets = {
  #   din = {
  #     file = ../../secrets/syncthing/dinraal.age;
  #     owner = "will";
  #   };
  #   glee = {
  #     file = ../../secrets/syncthing/gleeok.age;
  #     owner = "will";
  #   };
  #   nay = {
  #     file = ../../secrets/syncthing/naydra.age;
  #     owner = "will";
  #   };
  #   riju = {
  #     file = ../../secrets/syncthing/riju.age;
  #     owner = "will";
  #   };
  #   st-webpass = {
  #     file = ../../secrets/syncthing/web-pass.age;
  #     owner = "will";
  #   };
  # };

  # Syncthing ports
  networking.firewall.allowedTCPPorts = [8384 22000];
  networking.firewall.allowedUDPPorts = [22000 21027];
}
