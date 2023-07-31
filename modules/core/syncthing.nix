{
  lib,
  config,
  pkgs,
  ...
}: let
  # basically have to rewrite the entire init script from the module to load secrets before it syncs the config
  # this works for now, but is prone to breaking with updates
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/networking/syncthing.nix
  cfg = config.services.syncthing;
  cleanedConfig = lib.converge (lib.filterAttrsRecursive (_: v: v != null && v != {} && v != "secrets")) cfg.settings;

  devices = lib.mapAttrsToList (_: device:
    device
    // {
      deviceID = device.id;
    })
  cfg.settings.devices;

  folders = lib.mapAttrsToList (_: folder:
    folder
    // {
      devices = map (device: {deviceId = cfg.devices.${device}.id;}) folder.devices;
    }) (lib.filterAttrs (
      _: folder:
        folder.enable
    )
    cfg.settings.folders);

  secScripts = lib.mapAttrsToList (_: secret:
      {
        script = ''${sed} "s/${secret.id}/$(${bat} ${secret.path})/g"'';
      }) cfg.secrets;

  bat = "${lib.getExe pkgs.bat} -pp";
  sed = "${lib.getExe pkgs.gnused}";

  writeConf = pkgs.writers.writeBash "writeConf" ''
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
      new_cfg=$(printf '%s\n' "$old_cfg" | ${pkgs.jq}/bin/jq -c ${lib.escapeShellArg ''. * ${builtins.toJSON cleanedConfig} * {
                "devices": (${builtins.toJSON devices}${lib.optionalString (cfg.settings.devices == {} || ! cfg.overrideDevices) " + .devices"}),
                "folders": (${builtins.toJSON folders}${lib.optionalString (cfg.settings.folders == {} || ! cfg.overrideFolders) " + .folders"})
              }''})

      sec_cfg=$(echo $new_cfg${lib.concatMapStrings(s: " | ${s.script}") secScripts})

      # send the new config
      curl -X PUT -d "$sec_cfg" ${cfg.guiAddress}/rest/config

      # restart Syncthing if required
      if curl ${cfg.guiAddress}/rest/config/restart-required |
          ${pkgs.jq}/bin/jq -e .requiresRestart > /dev/null; then
          curl -X POST ${cfg.guiAddress}/rest/system/restart
      fi
    '';
in {

  config.systemd.services.syncthing-init.serviceConfig.ExecStart = lib.mkForce writeConf;

  options.services.syncthing.secrets = lib.mkOption {
    default = {};
    description = lib.mdDoc ''
      Secrets which should be loaded by Syncthing at runtime.
    '';
    example = lib.literalExpression ''
      {
        "/home/user/sync" = {
          id = "syncme";
          path = "/secret";
        };
      }
    '';
    type = lib.types.attrsOf (lib.types.submodule ({name, ...}: {
      options = {
        id = lib.mkOption {
          type = lib.types.str;
          description = lib.mdDoc ''
            The secret ID to be replaced.
          '';
        };
        path = lib.mkOption {
          type = lib.types.str;
          default = "/run/agenix/" + name;
          description = lib.mdDoc ''
            The path to the folder which should be shared.
          '';
        };
      };
    }));
  };
}
