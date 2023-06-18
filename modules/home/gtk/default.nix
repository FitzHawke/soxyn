{pkgs, ...}: {

  imports = [ ./gnomeapps ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["mauve"];
        size = "compact";
        variant = "mocha";
      };
    };
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "cat-mocha-mauve";
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
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_SIZE = "16";
    # Seem to need for GTK4
    GTK_THEME = "Catppuccin-Mocha-Compact-Mauve-Dark";
  };

  # catppuccin theme for qt-apps
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      accent = "Mauve";
      variant = "Mocha";
    })
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.Theme = "Catppuccin-Mocha-Mauve";
  };
}
