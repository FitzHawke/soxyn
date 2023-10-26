{...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "monospace";
      size = 12;
    };
    theme = "Catppuccin-Mocha";
    settings = {
      scrollback_lines = 4000;
      scrollback_pager_history_size = 2048;
      window_padding_width = 15;
    };
  };
}
