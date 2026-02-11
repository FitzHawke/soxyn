{pkgs, ...}: {
  home.packages = with pkgs; [
    # gui
    anki-bin # flashcards
    bitwarden-desktop # password manager
    chromium # backup browser
    element-desktop # matrix chat app
    foliate # ebook reader gui
    gimp # image editing
    jq # cli json parsing
    newsflash # RSS reader
    quodlibet-full # gui music

    # cli
    aoc-cli # advent of code cli util
    bc # calculator
    fd # simpler syntax for find
    catimg # cat for imgs
    comma # run commands without install (nix shell)
    ffmpeg # media conversions
    glow # render markdown in cli
    grex # generate regex expressions
    imagemagick # image conversion tools
    nmap # network scanning
    rbw # bitwarden cli
    ripgrep # rusty grep
    rsync # folder syncing
    sd # sed alt in rust with easy syntax
    sqlite # lightweight db
    unar # archive manager
    unzip # zip archive manager
    xh # http requests
    yt-dlp # youtube

    # other
    cached-nix-shell # faster nix shells
    lm_sensors # hardware sensor readouts
    alsa-plugins # extra codecs for alsa
  ];
}
