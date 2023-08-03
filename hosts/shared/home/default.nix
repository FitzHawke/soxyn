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
    inputs.anyrun.homeManagerModules.default

    ./packages.nix
    ./games.nix
    
    ./anyrun
    ./bottom
    ./discord
    ./firefox
    ./git
    ./hyprland
    ./kitty
    ./mako
    ./media
    ./neovim
    ./office
    ./rnnoise
    ./shell
    ./swaylock
    ./theme
    ./tools
    ./vscode
    ./zathura
  ];
}
