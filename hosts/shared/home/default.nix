{...}: {
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
    ./spotify
    ./swaylock
    ./theme
    ./tools
    ./vscode
    ./zathura
  ];
}
