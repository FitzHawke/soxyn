{
  pkgs,
  inputs,
  ...
}: {
  # themable spotify
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.packages.${pkgs.hostPlatform.system}.default;
  in {
    enable = true;

    theme = spicePkgs.themes.catppuccin-mocha;

    colorScheme = "mauve";

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      fullAppDisplay
      hidePodcasts
      shuffle
    ];
  };
}
