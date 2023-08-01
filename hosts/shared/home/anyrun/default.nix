{
  inputs,
  pkgs,
  ...
}: {
  programs.anyrun = {
    enable = true;
    package = inputs.anyrun.packages.${pkgs.system}.anyrun;
    config = {
      width.fraction = 0.3;
      x.fraction = 0.5;
      y.absolute = 15;
      ignoreExclusiveZones = false; # default
      layer = "overlay"; # default
      hidePluginInfo = true;
      closeOnClick = true;
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        randr
        shell
        rink
        symbols
        kidex
      ];
    };
    extraCss = ''
      * {
          transition: 200ms ease-out;
          font-family: Lexend;
          font-size: 1.1rem;
        }
        #window,
        #match,
        #entry,
        #plugin,
        #main {
          background: transparent;
        }
        #match:selected {
          background: rgba(203, 166, 247, 0.7);
        }
        #match {
          padding: 3px;
          border-radius: 16px;
        }
        #entry {
          border-radius: 16px;
        }
        box#main {
          background: rgba(30, 30, 46, 0.7);
          border: 1px solid #28283d;
          border-radius: 24px;
          padding: 8px;
        }
        row:first-child {
          margin-top: 6px;
        }
    '';
  };
}
