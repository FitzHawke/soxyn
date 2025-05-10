{...}: {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        term = "xterm-256color";
      };
    };
  };
}
