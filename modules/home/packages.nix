{ inputs
, pkgs
, config
, ...
}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    catimg
    cached-nix-shell
    firefox
    chromium
    element
    quodlibet
    todo
    yt-dlp
    hyperfine
    glow
    nmap
    unzip
    rsync
    ffmpeg
    gimp
    imagemagick
    bc
    bandwhich
    grex
    fd
    xh
    jq
    lm_sensors
    keepassxc
    dconf
  ];
}
