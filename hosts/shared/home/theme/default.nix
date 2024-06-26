{pkgs, ...}: let
  catppuccin_name = "catppuccin-mocha-mauve-compact+default";
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = ["mauve"];
    size = "compact";
    variant = "mocha";
  };
in {
  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = catppuccin_name;
      package = catppuccin;
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    font = {
      name = "Lexend";
      size = 10; #13
    };
  };

  # cursor theme
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "catppuccin-mocha-dark-cursors";
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_SIZE = "24";
  };

  # catppuccin theme for qt-apps
  home.packages = with pkgs; [
    gnome.gnome-themes-extra
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      accent = "Mauve";
      variant = "Mocha";
    })
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.Theme = "Catppuccin-Mocha-Mauve";
  };
}
