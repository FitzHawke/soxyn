{
  config,
  pkgs,
  ...
}: let
  kitty-xterm = pkgs.writeShellScriptBin "xterm" ''
    ${config.programs.kitty.package}/bin/kitty -1 "$@"
  '';
in {
  home = {
    packages = [kitty-xterm];
    sessionVariables = {
      TERMINAL = "kitty -1";
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "monospace";
      size = 12;
    };
    theme = "Catppuccin-Mocha";
    settings = {
      scrollback_lines = 4000;
      scrollback_pager_history_size = 2048;
      window_padding_width = 15;
    };
  };
}
