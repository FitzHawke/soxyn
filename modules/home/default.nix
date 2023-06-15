{ inputs
, pkgs
, config
, lib
, self
, ...
}:
# glue all configs together
{
  config.home.stateVersion = "23.05";
  config.home.extraOutputsToInstall = [ "doc" "devdoc" ];
  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.nix-index-db.hmModules.nix-index
    inputs.spicetify-nix.homeManagerModule

    ./packages.nix
    ./games.nix

    ./anyrun
    ./bottom
    ./discord
    ./git
    ./gtk
    ./hyprland
    ./kitty
    ./mako
    ./media
    ./neovim
    ./rnnoise
    ./shell
    ./spotify
    ./swaylock
    ./tools
    ./vscode
    ./waybar
    ./zathura
  ];
}
