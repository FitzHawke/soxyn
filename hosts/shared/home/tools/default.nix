{
  pkgs,
  config,
  ...
}: let
  browser = ["firefox.desktop"];
  audioPlayer = ["io.bassi.Amberol.desktop"];
  imageViewer = ["org.gnome.Loupe.desktop"];
  videoPlayer = ["io.github.celluloid_player.Celluloid.desktop"];

  # custom settings for default applicatuions
  associations = {
    # web related
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;
    "application/json" = browser;

    # audio
    "audio/*" = audioPlayer;
    "audio/aac" = audioPlayer;
    "audio/flac" = audioPlayer;
    "audio/x-vorbis+ogg" = audioPlayer;
    "audio/opus" = audioPlayer;
    "audio/mp3" = audioPlayer;
    "audio/wav" = audioPlayer;

    # images
    "image/*" = imageViewer;
    "image/gif" = imageViewer;
    "image/jpeg" = imageViewer;
    "image/jpg" = imageViewer;
    "image/png" = imageViewer;
    "image/svg+xml" = imageViewer;

    # video
    "video/*" = videoPlayer;
    "video/avi" = videoPlayer;
    "video/mkv" = videoPlayer;
    "video/mp4" = videoPlayer;
    "video/mpeg" = videoPlayer;

    # other
    "text/*" = ["org.gnome.TextEditor.desktop"];
    "text/plain" = ["org.gnome.TextEditor.desktop"];
    "inode/directory" = ["org.gnome.Nautilus.desktop"];
    "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
    "x-scheme-handler/spotify" = ["spotify.desktop"];
    "x-scheme-handler/discord" = ["discord.desktop"];
    "x-scheme-handler/element" = ["element-desktop.desktop"];
    "x-scheme-handler/chrome" = ["chromium-browser.desktop"];
    "x-scheme-handler/steam" = ["steam.desktop"];
  };
in {
  services = {
    udiskie.enable = true;
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-gnome3;
      enableSshSupport = true;
      enableFishIntegration = true;
    };
  };
  programs = {
    gpg.enable = true;
    man.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    tealdeer = {
      enable = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = true;
        };
      };
    };
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };
  };
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      videos = "${config.home.homeDirectory}/media/videos";
      music = "${config.home.homeDirectory}/media/music";
      pictures = "${config.home.homeDirectory}/media/pictures";
      desktop = "${config.home.homeDirectory}/other";
      publicShare = "${config.home.homeDirectory}/other";
      templates = "${config.home.homeDirectory}/other";
    };
    mimeApps.enable = true;
    mimeApps.defaultApplications = associations;
  };
}
