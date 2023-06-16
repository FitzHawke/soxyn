{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    bandwhich
    bc
    catimg
    cached-nix-shell
    chromium
    dconf
    element
    fd
    ffmpeg
    gimp
    glow
    grex
    hyperfine
    imagemagick
    jq
    keepassxc
    lm_sensors
    nmap
    quodlibet
    rsync
    todo
    unzip
    xh
    yt-dlp
  ];
}
