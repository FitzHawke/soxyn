{
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    #!/bin/bash
    hyprctl keyword animation "fadeOut,0,8,slow" && ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -w 0 -b 5e81acd2)" - | swappy -f -; hyprctl keyword animation "fadeOut,1,8,slow"
  '';
in {
  imports = [./config.nix];
  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast
    libnotify
    wf-recorder
    brillo
    pamixer
    python39Packages.requests
    slurp
    swappy
    screenshot
    wl-clipboard
    pngquant
    cliphist
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
  };

  services.wlsunset = {
    enable = true;
    latitude = "43.95";
    longitude = "-81.22";
    temperature = {
      day = 6200;
      night = 3750;
    };
  };

  programs.eww-hyprland = {
    enable = true;
    package = inputs.eww.packages.${pkgs.hostPlatform.system}.eww-wayland.overrideAttrs (prev: {
      src = fetchFromGithub {
        owner = "ralismark";
        repo = "eww";
        rev = "5f69d75f75e47597d4ccb4d0fb1d0fc4f1440370";
        hash = "something";
      };
    });
  };

  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };

  systemd.user.services = {
    swaybg = mkService {
      Unit.Description = "Wallpaper chooser";
      Service = {
        ExecStart = "${lib.getExe pkgs.swaybg} -i ${./wall.jpg} -m stretch";
        Restart = "always";
      };
    };
    cliphist = mkService {
      Unit.Description = "Clipboard history";
      Service = {
        ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getExe pkgs.cliphist} store";
        Restart = "always";
      };
    };
  };
}
