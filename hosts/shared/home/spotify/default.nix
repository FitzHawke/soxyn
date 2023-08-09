{
  inputs,
  pkgs,
  ...
}: let spicePkgs = inputs.spicetify.packages.${pkgs.system}.default; in{
  imports = [inputs.spicetify.homeManagerModule];
  programs.spicetify = {
    enable = true;
    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus
      new-releases
    ];

    theme = spicePkgs.themes.catppuccin-mocha;
    colorScheme = "mauve";

    enabledExtensions = with spicePkgs.extensions; [
      autoSkipVideo
      shuffle
      popupLyrics

      fullAppDisplayMod
      hidePodcasts
      history
      adblock
      playlistIcons
      autoSkip
    ];
  };
}
