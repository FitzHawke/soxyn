{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  dependencies = with pkgs; [
    inputs.gross.packages.${system}.gross
    inputs.eww.packages.${system}.eww-wayland
    config.wayland.windowManager.hyprland.package

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
    ripgrep
    socat
    udev
    upower
    util-linux
    wget
    wireplumber
    wlogout
  ];
  eww-pack = inputs.eww.packages.${pkgs.system}.eww-wayland;
in {
  home.packages = [
    eww-pack
  ];

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
  xdg.configFile."eww/css/_colors.scss".text = builtins.readFile ./css/_colors.scss;

  systemd.user.services.eww = {
    Unit = {
      Description = "Eww Daemon";
      PartOf = ["tray.target" "graphical-session.target"];
    };
    Service = {
      Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
      ExecStart = "${eww-pack}/bin/eww daemon --no-daemonize";
      ExecStartPost = "${eww-pack}/bin/eww open bar";
      Restart = "on-failure";
    };
    # temp disabled due to when starting automatically and using hyprland to open the bar
    # the unit would not be started until after hyprland had already initialized eww,
    # causing this unit to start a seperate eww daemon. And the bar to be tied to the wrong env
    # Install.WantedBy = ["graphical-session.target"];
  };
}
