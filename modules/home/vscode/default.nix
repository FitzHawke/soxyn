{ config, pkgs, ... }: {
  home.sessionVariables.EDITOR = "nvim";
  programs.vscode.enable = true;
}
