{
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles = {
      will = {
        id = 0;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          keepassxc-browser
          reddit-enhancement-suite
          ublock-origin
        ];

        settings = {
          "media.ffmpeg.vaapi.enabled" = true;
          "extensions.pocket.enabled" = false;
          "extensions.pocket.onSaveRecs" = false;
          "browser.disableResetPrompt" = true;
          "browser.download.panel.shown" = true;
          "browser.download.useDownloadDir" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.startup.homepage" = "https://start.duckduckgo.com";
          "privacy.trackingprotection.enabled" = true;
          "signon.rememberSignons" = false;
        };
      };
    };
  };
}