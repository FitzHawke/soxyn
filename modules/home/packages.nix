{
  pkgs,
  inputs,
  ...
}: let
  nur-modules = import inputs.nur {
    nurpkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  };
in {
  home.packages = with pkgs; [
    nur-modules.repos.colinsane.pkgs.lemoa
    anki-bin
    bandwhich
    bc
    blueberry
    catimg
    cached-nix-shell
    chromium
    element-desktop
    fd
    ffmpeg
    foliate
    gimp
    glow
    grex
    hyperfine
    imagemagick
    jellyfin-media-player
    jq
    lm_sensors
    newsflash
    nmap
    obsidian
    quodlibet-full
    rsync
    todo
    unzip
    xh
    yt-dlp
  ];
}
