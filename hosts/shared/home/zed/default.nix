{
  pkgs,
  lib,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      # https://github.com/zed-industries/zed/tree/main/extensions
      "emmet"
      "html"
      "toml"

      # https://github.com/zed-industries/extensions/tree/main/extensions
      "astro"
      "basher"
      "catppuccin"
      "git-firefly"
      "nix"
      "scss"
      "svelte"
      "typos"
      "xml"
    ];

    userSettings = {
      features = {
        inline_completion_provider = "none";
      };

      hourFormat = "hour24";
      autoUpdate = false;

      autosave = "on_focus_change";
      load_direnv = "shell_hook";

      node = {
        path = lib.getExe pkgs.nodePackages_latest.nodejs;
        npm_path = lib.getExe' pkgs.nodePackages_latest.nodejs "npm";
      };

      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };
        package-version-server = {
          binary = {
            path = lib.getExe pkgs.package-version-server;
          };
        };
        typos = {
          binary = {
            path = lib.getExe pkgs.typos-lsp;
          };
          initialization_options = {
            diagnosticSeverity = "Information";
          };
        };
        rust-analyser = {
          binary = {
            path_lookup = true;
          };
        };
      };

      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
          formatter = {
            external = {
              command = "alejandra";
              arguments = ["--quiet" "--"];
            };
          };
        };
      };
    };
  };
}
