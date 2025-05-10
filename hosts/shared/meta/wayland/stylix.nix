{pkgs, ...}: {
  fonts.packages = with pkgs; [
    material-icons
    material-symbols
    material-design-icons
    roboto
    work-sans
    comic-neue
    source-sans
    twemoji-color-font
    comfortaa
    inter
    lato
    lexend
    jost
    dejavu_fonts
    iosevka-bin
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    fonts = {
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 10;
      };

      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };

      monospace = {
        name = "Iosevka Nerd Font Mono";
        package = pkgs.nerd-fonts.iosevka;
      };

      sansSerif = {
        name = "Lexend";
        package = pkgs.lexend;
      };

      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };
    };
  };
}
