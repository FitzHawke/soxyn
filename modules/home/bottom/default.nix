{pkgs, ...}: {
  # universal aliases
  home.packages = with pkgs; [
    (writeScriptBin "htop" ''exec btm'')
    (writeScriptBin "top" ''exec btm'')
  ];
  # can get a list of configurable settings by generating a new config with bottom
  #   btm -C btm.toml
  programs.bottom = {
    enable = true;
    settings = {
      flags.group_processes = true;
      row = [
        {
          ratio = 30;
          child = [{type = "cpu";}];
        }
        {
          ratio = 40;
          child = [
            {
              ratio = 4;
              type = "mem";
            }
            {
              ratio = 3;
              child = [
                {type = "temp";}
                {type = "disk";}
              ];
            }
          ];
        }
        {
          ratio = 30;
          child = [
            {type = "net";}
            {
              type = "proc";
              default = true;
            }
          ];
        }
      ];
    };
  };
}
