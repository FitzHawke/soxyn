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

      ui_font_size = 16;
      buffer_font_size = 12;
      hourFormat = "hour24";
      autoUpdate = false;

      theme = {
        mode = "system";
        light = "One Light";
        dark = "Catppuccin Mocha";
      };

      autosave = "on_focus_change";
      buffer_font_family = "Iosevka Nerd Font Mono";
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
