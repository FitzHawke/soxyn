{
  inputs',
  ...
}: {
  imports = [inputs'.spicetify.homeManagerModule];
  programs.spicetify = {
    enable = true;
    enabledCustomApps = with inputs'.spicetify.default; [
      lyrics-plus
      new-releases
    ];

    theme = inputs'.spicetify.default.themes.catppuccin-mocha;
    colorScheme = "mauve";

    enabledExtensions = with inputs'.spicetify.default; [
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
