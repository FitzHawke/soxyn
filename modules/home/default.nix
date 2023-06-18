{inputs, ...}:
# glue all configs together
{
  config = {
    home.stateVersion = "23.05";
    home.extraOutputsToInstall = ["doc" "devdoc"];
    manual = {
      html.enable = false;
      json.enable = false;
      manpages.enable = false;
    };
  };
  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.nix-index-db.hmModules.nix-index
    inputs.spicetify-nix.homeManagerModule

    ./packages.nix
    ./games.nix
    
    ./anyrun
    ./bottom
    ./discord
    ./firefox
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
    ./syncthing
    ./tools
    # ./waybar
    ./vscode
    ./zathura
  ];
}
