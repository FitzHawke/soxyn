{...}: {
  config = {
    home.stateVersion = "23.05";
    home.extraOutputsToInstall = ["doc" "devdoc"];
    home.language.base = "en_US.UTF-8";

    manual = {
      html.enable = false;
      json.enable = false;
      manpages.enable = false;
    };

    nix = {
      gc = {
        automatic = true;
        frequency = "daily";
        options = "--delete-older-than 3d";
      };
    };
  };

  imports = [
    ./packages.nix
    ./games.nix

    ./ags
    ./bottom
    ./discord
    ./firefox
    ./git
    ./hyprland
    ./media
    # the rotating circus of breakages in nix
    # ./neovim
    ./office
    ./rnnoise
    ./shell
    ./spotify
    ./terminal
    ./theme
    ./tools
    ./vscode
    ./zathura
  ];
}
