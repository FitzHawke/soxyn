# all credit goes to Misterio77 for this module
# https://github.com/Misterio77/nix-config/blob/main/modules/home-manager/monitors.nix
{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.monitors = mkOption {
    type = types.listOf (types.submodule {
      options = {
        name = mkOption {
          type = types.str;
          example = "DP-1";
        };
        primary = mkOption {
          type = types.bool;
          default = false;
        };
        noBar = mkOption {
          type = types.bool;
          default = false;
        };
        width = mkOption {
          type = types.int;
          example = 1920;
        };
        height = mkOption {
          type = types.int;
          example = 1080;
        };
        refreshRate = mkOption {
          type = types.int;
          default = 60;
        };
        x = mkOption {
          type = types.int;
          default = 0;
        };
        y = mkOption {
          type = types.int;
          default = 0;
        };
        enabled = mkOption {
          type = types.bool;
          default = true;
        };
        workspace = mkOption {
          type = types.nullOr types.str;
          default = null;
        };
        wallpaper = mkOption {
          type = types.nullOr types.path;
          default = null;
        };
      };
    });
  };
  options.extraHyprConf = mkOption {
    type = types.str;
    default = "";
  };
  config = {
    assertions = [
      {
        assertion = (lib.length (lib.filter (m: m.primary) config.monitors)) == 1;
        message = "Exactly one monitor must be set to primary.";
      }
    ];
  };
}
