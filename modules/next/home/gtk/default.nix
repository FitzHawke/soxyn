{ self
, pkgs
, lib
, config
, inputs
, ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        variant = "frappe";
      };
    };
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Catpuccin-Papirus";
    };
    font = {
      name = "Lexend";
      size = 13;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  # cursor theme
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.frappeDark;
    name = "Catppuccin-Frappe-Dark-Cursors";
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    # XCURSOR_SIZE = lib.mkOverride "16";
    XCURSOR_SIZE = "16";
  };

  # credits: bruhvko
  # catppuccin theme for qt-apps
  home.packages = with pkgs; [ libsForQt5.qtstyleplugin-kvantum ];

  xdg.configFile."Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Mocha-Pink/Catppuccin-Mocha-Pink.kvconfig";
    sha256 = "13ci6bzi41pazvpbylwqxhwjv4w8af50g26qqfh3xbaxjwfgdk1d";
  };
  xdg.configFile."Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Mocha-Pink/Catppuccin-Mocha-Pink.svg";
    sha256 = "1rlxd9w2ifddc62rdyddzdbglc64wf7k6w7hlxfy85hwmn35m683";
  };
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=catppuccin

    [Applications]
    catppuccin=Dolphin, dolphin, Nextcloud, nextcloud, qt5ct, org.kde.dolphin, org.kde.kalendar, kalendar, Kalendar, qbittorrent, org.qbittorrent.qBittorrent
  '';
}
