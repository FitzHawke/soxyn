{config,...}: {
  services.syncthing = {
    enable = true;
    user = "will";
    dataDir = "/home/will/sync"; # Default folder for new synced folders
    configDir = "/home/will/.config/syncthing"; # Folder for Syncthing's settings and keys
    overrideDevices = true; # overrides any devices added or deleted through the WebUI
    overrideFolders = true; # overrides any folders added or deleted through the WebUI
    guiAddress = "0.0.0.0:8384";
    devices = {
      "dinraal" = {id = "$ST_DINRAAL_KEY";};
      "naydra" = {id = "$ST_NAYDRA_KEY";};
      "gleeok" = {id = "$ST_GLEEOK_KEY";};
      "riju" = {id = "$ST_RIJU_KEY";};
    };
    folders = {
      "base" = {
        # Name of folder in Syncthing, also the folder ID
        path = "/home/will/sync/base"; # Which folder to add to Syncthing
        devices = ["dinraal" "naydra" "gleeok" "riju"]; # Which devices to share the folder with
      };
      "flood" = {
        path = "/home/will/sync/flood";
        devices = ["dinraal" "naydra" "gleeok"];
      };
    };
    extraOptions.gui = {
      user = "fitzhawke";
      password = "$ST_WEB_PASS";
    };
  };

  # add env file from sops with secrets
  systemd.services.syncthing.serviceConfig.EnvironmentFile = "${config.sops.secrets.st-keys.path}";

  sops.secrets.st-keys.owner = "will";

  # Syncthing ports
   networking.firewall.allowedTCPPorts = [ 8384 22000 ];
   networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
