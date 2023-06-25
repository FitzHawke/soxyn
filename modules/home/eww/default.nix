{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: { 
  home.packages = with pkgs; [
    bash
    blueberry
    bluez
    brillo
    coreutils
    dbus
    inputs.eww.packages.${system}.eww-wayland
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
}
