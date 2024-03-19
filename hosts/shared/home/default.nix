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
  };
  imports = [
    ./packages.nix
    ./games.nix

    ./ags
    ./anyrun
    ./bottom
    ./discord
    ./firefox
    ./git
    ./hyprland
    ./mako
    ./media
    ./neovim
    ./office
    ./rnnoise
    ./shell
    ./spotify
    # ./swaylock
    ./terminal
    ./theme
    ./tools
    ./vscode
    ./zathura
  ];
}
