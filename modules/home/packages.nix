{pkgs, ...}: {
  home.packages = with pkgs; [
    # gui
    anki-bin # flashcards
    blueberry # bluetooth gui
    chromium # backup browser
    element-desktop # matrix chat app
    foliate # ebook reader gui
    gimp # image editing
    jellyfin-media-player # gui for connecting with jellyfin servers
    jq # cli json parsing
    newsflash # RSS reader
    obsidian # markdown knowledge base
    quodlibet-full # gui music

    # cli
    bc # calculator
    fd # simpler syntax for find
    catimg # cat for imgs
    ffmpeg # media conversions
    glow # render markdown in cli
    grex # generate regex expressions
    hyperfine # benchmarking tool
    imagemagick # image conversion tools
    nmap # network scanning
    rsync # folder syncing
    sd # sed alt in rust with easy syntax
    unzip # archive manager
    xh # http requests
    yt-dlp # youtube

    # other
    cached-nix-shell # faster nix shells
    lm_sensors # hardware sensor readouts

    # testing
    anytype # cloud-synced organizer `everything app`
  ];
}
