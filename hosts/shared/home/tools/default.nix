{
  pkgs,
  config,
  ...
}: 
let
  browser = ["firefox.desktop"];

  # custom settings for default applicatuions
  associations = {
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

    # /* doesn't work for all associations. TODO list out audio/video/image/text types manually
    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["imv.desktop"];
    "text/*" = ["org.gnome.TextEditor.desktop"];
    "text/plain" = ["org.gnome.TextEditor.desktop"];
    "inode/directory" = ["org.gnome.Nautilus.desktop"];
    "application/json" = browser;
    "application/pdf" = ["org.pwmt.zathura.desktop"];
    "x-scheme-handler/spotify" = ["spotify.desktop"];
    "x-scheme-handler/discord" = ["webcord.desktop"];
    "x-scheme-handler/element" = ["element-desktop.desktop"];
    "x-scheme-handler/chrome" = ["chromium-browser.desktop"];
    "x-scheme-handler/anytype" = ["anytype.desktop"];
    "x-scheme-handler/steam" = ["steam.desktop"];
  };
in 
{
  services = {
    udiskie.enable = true;
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
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
        theme = "Catppuccin-mocha";
      };
      themes = {
        Catppuccin-mocha = builtins.readFile (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/bat/ba4d16880d63e656acced2b7d4e034e4a93f74b1/Catppuccin-mocha.tmTheme";
          hash = "sha256-qMQNJGZImmjrqzy7IiEkY5IhvPAMZpq0W6skLLsng/w=";
        });
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
