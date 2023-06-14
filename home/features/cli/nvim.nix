{ config, pkgs, ... }: {
  home.sessionVariables.EDITOR = "nvim";
  programs.neovim.enable = true;
}
