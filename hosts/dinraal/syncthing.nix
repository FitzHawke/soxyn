{
  config,
  ...
}: {
  services.syncthing = {
    enable = true;
    user = "will";
    dataDir = "/home/will/sync"; # Default folder for new synced folders
    configDir = "/home/will/.config/syncthing"; # Folder for Syncthing's settings and keys
    overrideDevices = true; # overrides any devices added or deleted through the WebUI
    overrideFolders = true; # overrides any folders added or deleted through the WebUI
    guiAddress = "0.0.0.0:8384";
    settings = {
      devices = {
        "farosh" = {id = "ST_FAROSH_KEY";};
        "naydra" = {id = "ST_NAYDRA_KEY";};
        "gleeok" = {id = "ST_GLEEOK_KEY";};
        "riju" = {id = "ST_RIJU_KEY";};
      };
      folders = {
        "base" = {
          # Name of folder in Syncthing, also the folder ID
          path = "/home/will/sync/base"; # Which folder to add to Syncthing
          devices = ["farosh" "naydra" "gleeok" "riju"]; # Which devices to share the folder with
        };
        "flood" = {
          path = "/home/will/sync/flood";
          devices = ["farosh" "naydra" "gleeok"];
        };
      };
      gui = {
        user = "fitzhawke";
        password = "ST_WEB_PASS";
      };
    };

    # custom settings added from ../common/syncthing
    # path defaults to '/run/agenix/' + secret name
    secrets = {
      "far" = {id="ST_FAROSH_KEY";};
      "nay" = {id="ST_NAYDRA_KEY";};
      "glee" = {id="ST_GLEEOK_KEY";};
      "riju" = {id="ST_RIJU_KEY";};
      "pass" = {id="ST_WEB_PASS";};
    };
  };

  age.secrets = {
    far = {
      file = ../../secrets/syncthing/farosh.age;
      owner = config.services.syncthing.user;
    };
    glee = {
      file = ../../secrets/syncthing/gleeok.age;
      owner = config.services.syncthing.user;
    };
    nay = {
      file = ../../secrets/syncthing/naydra.age;
      owner = config.services.syncthing.user;
    };
    riju = {
      file = ../../secrets/syncthing/riju.age;
      owner = config.services.syncthing.user;
    };
    pass = {
      file = ../../secrets/syncthing/web_pass.age;
      owner = config.services.syncthing.user;
    };
  };

  # Syncthing ports
  networking.firewall.allowedTCPPorts = [8384 22000];
  networking.firewall.allowedUDPPorts = [22000 21027];
}
