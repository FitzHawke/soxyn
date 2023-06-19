{
  config,
  pkgs,
  lib,
  ...
}: let
  dependencies = with pkgs; [
    config.wayland.windowManager.hyprland.package
    bash
    blueberry
    bluez
    brillo
    coreutils
    dbus
    eww-wayland
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
  home.packages = [
    # (inputs.eww.packages.${system}.eww-wayland.overrideAttrs
    #   (old: {
    #     src = pkgs.fetchFromGitHub {
    #       owner = "ralismark";
    #       repo = "eww";
    #       rev = "5f69d75f75e47597d4ccb4d0fb1d0fc4f1440370";
    #       hash = "sha256-o38cXPG296Ojyg7QN4SyVg4HqdO1s8Y1Pei4N5PcMGo=";
    #     };
    #   }))
    pkgs.eww-wayland
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
      # not yet implemented
      # PartOf = ["tray.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
      ExecStart = "${lib.getExe pkgs.eww-wayland} daemon --no-daemonize";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
