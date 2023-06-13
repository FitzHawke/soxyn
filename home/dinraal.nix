{ inputs, outputs, ... }: {
  # You can import other home-manager modules here
  imports = [
    ./common
    ./features/desktop/hyprland
    ./features/games
  ];

  wallpaper = outputs.wallpapers.aenami-lunar;
  colorscheme = inputs.nix-colors.colorSchemes.atelier-heath;
}
