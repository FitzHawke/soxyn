{
  config,
  pkgs,
  lib,
  ...
}: let
  dependencies = with pkgs; [
    config.wayland.windowManager.hyprland.package
    cfg.package
    bash
    blueberry
    bluez
    brillo
    coreutils
    dbus
    findutils
    gawk
    gnome.gnome-control-center
    gnused
    imagemagick
    jaq
    jc
    libnotify
    networkmanager
    pavucontrol
    playerctl
    procps
    pulseaudio
    ripgrep
    socat
    udev
    upower
    util-linux
    wget
    wireplumber
    wlogout
  ];
in {
    home.packages = [ pkgs.eww-wayland ];

    # remove nix files
    xdg.configFile."eww" = {
      source = lib.cleanSourceWith {
        filter = name: _type: let
          baseName = baseNameOf (toString name);
        in
          !(lib.hasSuffix ".nix" baseName) && (baseName != "_colors.scss");
        src = lib.cleanSource ./.;
      };

      # links each file individually, which lets us insert the colors file separately
      recursive = true;
    };

    # colors file
    xdg.configFile."eww/css/_colors.scss".text = (builtins.readFile ./css/_colors.scss);

    systemd.user.services.eww = {
      Unit = {
        Description = "Eww Daemon";
        # not yet implemented
        # PartOf = ["tray.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
        ExecStart = "${config.programs.eww-wayland.package}/bin/eww daemon --no-daemonize";
        Restart = "on-failure";
      };
      Install.WantedBy = ["graphical-session.target"];
    };
  
}
