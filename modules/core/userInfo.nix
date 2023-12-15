# an attempt at a module to define things like userName that get reused to generalize the config
# may not last long term as most of this has a direct mapping to settings already present
# and I'm not a fan of unnecessarily duplicating existing work.
# But for now it's here. Until I restructure to where its not needed.
{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.userInfo = mkOption {
    type = types.listOf (types.submodule {
      options = {
        userName = mkOption {
          type = types.str;
          example = "fitz";
        };
        useInitialPassword = mkOption {
          type = types.bool;
          default = false;
        };
        initialPassword = mkOption {
          type = types.str;
          example = "changeme";
        };
        useSecretPassword = mkOption {
          type = types.bool;
          default = false;
        };
        secretPasswordLoc = mkOption {
          type = types.str;
          example = "users/pass";
        };
        secretPasswordFile = mkOption {
          type = types.path;
          example = "../secrets/users/pass.age";
        };
        uid = mkOption {
          type = types.int;
          example = 1000;
        };
        sshAuthKeys = mkOption {
          type = types.listOf types.str;
          # mine for example
          example = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMPxvQbxhePTrxcb8zJ4UNttu+L44yCqGsa3VaEcFoxl will@fitzhawk.com"];
        };
        # primary = mkOption {
        #   type = types.bool;
        #   default = false;
        # };
        # noBar = mkOption {
        #   type = types.bool;
        #   default = false;
        # };
        # width = mkOption {
        #   type = types.int;
        #   example = 1920;
        # };
        # height = mkOption {
        #   type = types.int;
        #   example = 1080;
        # };
        # refreshRate = mkOption {
        #   type = types.int;
        #   default = 60;
        # };
        # x = mkOption {
        #   type = types.int;
        #   default = 0;
        # };
        # y = mkOption {
        #   type = types.int;
        #   default = 0;
        # };
        # enabled = mkOption {
        #   type = types.bool;
        #   default = true;
        # };
        # workspace = mkOption {
        #   type = types.nullOr types.str;
        #   default = null;
        # };
        # wallpaper = mkOption {
        #   type = types.nullOr types.path;
        #   default = null;
        # };
      };
    });
  };
  config = {
    assertions = [
      {
        assertion = config.userInfo.useInitialPassword == true && config.userInfo.useSecretPassword == true;
        message = "useInitialPassword and useSecretPassword are mutually exclusive.";
      }
      {
        assertion = config.userInfo.useInitialPassword == false && config.userInfo.useSecretPassword == false;
        message = "need to select either useInitialPassword or useSecretPassword.";
      }
      {
        assertion = config.userInfo.useInitialPassword == true && config.userInfo.initialPassword == null;
        message = "initialPassword is required when useInitialPassword is true.";
      }
      {
        assertion = config.userInfo.useSecretPassword == true && (config.userInfo.secretPasswordLoc == null || config.userInfo.secretPasswordFile == null);
        message = "secretPasswordLoc and secretPasswordFile are required when useSecretPassword is true.";
      }
    ];
  };
}
