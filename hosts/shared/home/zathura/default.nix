{...}: {
  programs.zathura = {
    enable = true;
    options = {
      font = "Iosevka 16";

      statusbar-h-padding = 10;
      statusbar-v-padding = 10;

      recolor = true;

      selection-clipboard = "clipboard";
      adjust-open = "best-fit";
      pages-per-row = "1";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
      smooth-scroll = true;
      zoom-min = "10";
    };
  };
}
