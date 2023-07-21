{
  lib,
  config,
  pkgs,
  ...
}: let
  # basically have to rewrite the script from the module to sync secrets in
  # there has to be a better way, but this works for now
  # 
  cfg = config.services.syncthing;

  devices = lib.mapAttrsToList (name: device: {
    deviceID = device.id;
    inherit (device) name addresses introducer autoAcceptFolders;
  }) cfg.devices;

  folders = lib.mapAttrsToList ( _: folder: {
    inherit (folder) path id label type;
    devices = map (device: { deviceId = cfg.devices.${device}.id; }) folder.devices;
    rescanIntervalS = folder.rescanInterval;
    fsWatcherEnabled = folder.watch;
    fsWatcherDelayS = folder.watchDelay;
    ignorePerms = folder.ignorePerms;
    ignoreDelete = folder.ignoreDelete;
    versioning = folder.versioning;
  }) (lib.filterAttrs (
    _: folder:
    folder.enable
  ) cfg.folders);
  addSecrets = let
    bat = "${lib.getExe pkgs.bat} -pp";
    sed = "${lib.getExe pkgs.gnused}";
  in pkgs.writers.writeBash "addSecrets" ''
    set -efu

    # be careful not to leak secrets in the filesystem or in process listings

    umask 0077

    # get the api key by parsing the config.xml
    while
        ! ${pkgs.libxml2}/bin/xmllint \
            --xpath 'string(configuration/gui/apikey)' \
            ${cfg.configDir}/config.xml \
            >"$RUNTIME_DIRECTORY/api_key"
    do sleep 1; done

    (printf "X-API-Key: "; cat "$RUNTIME_DIRECTORY/api_key") >"$RUNTIME_DIRECTORY/headers"

    curl() {
        ${pkgs.curl}/bin/curl -sSLk -H "@$RUNTIME_DIRECTORY/headers" \
            --retry 1000 --retry-delay 1 --retry-all-errors \
            "$@"
    }

    # query the old config
    old_cfg=$(curl ${cfg.guiAddress}/rest/config)

    # generate the new config by merging with the NixOS config options
    new_cfg=$(printf '%s\n' "$old_cfg" | ${pkgs.jq}/bin/jq -c '. * {
        "devices": ('${lib.escapeShellArg (builtins.toJSON devices)}'${lib.optionalString (cfg.devices == {} || ! cfg.overrideDevices) " + .devices"}),
        "folders": ('${lib.escapeShellArg (builtins.toJSON folders)}'${lib.optionalString (cfg.folders == {} || ! cfg.overrideFolders) " + .folders"})
    } * '${lib.escapeShellArg (builtins.toJSON cfg.extraOptions)})

    dinraal="$(${bat} /run/agenix/din)"
    naydra="$(${bat} /run/agenix/nay)"
    gleeok="$(${bat} /run/agenix/glee)"
    riju="$(${bat} /run/agenix/riju)"
    web_pass="$(${bat} /run/agenix/pass)"

    sec_cfg=$(echo $new_cfg | \
      ${sed} "s/ST_DINRAAL_KEY/$dinraal/g" | \
      ${sed} "s/ST_NAYDRA_KEY/$naydra/g" | \
      ${sed} "s/ST_GLEEOK_KEY/$gleeok/g" | \
      ${sed} "s/ST_RIJU_KEY/$riju/g" | \
      ${sed} "s/ST_WEB_PASS/$web_pass/g")

    # send the new config
    curl -X PUT -d "$sec_cfg" ${cfg.guiAddress}/rest/config

    # restart Syncthing if required
    if curl ${cfg.guiAddress}/rest/config/restart-required |
       ${pkgs.jq}/bin/jq -e .requiresRestart > /dev/null; then
        curl -X POST ${cfg.guiAddress}/rest/system/restart
    fi
  '';
in {
  services.syncthing = {
    enable = true;
    user = "will";
    dataDir = "/home/will/sync"; # Default folder for new synced folders
    configDir = "/home/will/.config/syncthing"; # Folder for Syncthing's settings and keys
    overrideDevices = true; # overrides any devices added or deleted through the WebUI
    overrideFolders = true; # overrides any folders added or deleted through the WebUI
    guiAddress = "0.0.0.0:8384";
    devices = {
      "dinraal" = {id = "ST_DINRAAL_KEY";};
      "naydra" = {id = "ST_NAYDRA_KEY";};
      "gleeok" = {id = "ST_GLEEOK_KEY";};
      "riju" = {id = "ST_RIJU_KEY";};
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
      password = "ST_WEB_PASS";
    };
  };

  systemd.services.syncthing-init.serviceConfig.ExecStart = lib.mkForce addSecrets;

  age.secrets = {
    din = {
      file = ../../secrets/syncthing/dinraal.age;
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
