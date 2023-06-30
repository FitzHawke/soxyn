{
  pkgs,
  lib,
  ...
}: {
  services = {
    dbus = {
      packages = with pkgs; [dconf gcr udisks2];
      enable = true;
    };
    udev.packages = with pkgs; [gnome.gnome-settings-daemon android-udev-rules];
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
    udisks2.enable = true;
  };

  programs = {
    dconf.enable = true;
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';
  };

  # compress half of the ram to use as swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  environment.systemPackages = with pkgs; [
    git
    steam-run
    appimage-run
    (writeScriptBin "sudo" ''exec doas "$@"'')
  ];

  time = {
    timeZone = "America/Toronto";
    hardwareClockInLocalTime = false;
  };
  hardware.ledger.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  console = let
    variant = "u24n";
  in {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-${variant}.psf.gz";
    keyMap = "us";
  };

  boot.binfmt.registrations = lib.genAttrs ["appimage" "AppImage"] (ext: {
    recognitionType = "extension";
    magicOrExtension = ext;
    interpreter = "/run/current-system/sw/bin/appimage-run";
  });

  # programs.nix-ld = {
  #   enable = true;
  #   libraries = with pkgs; [
  #     stdenv.cc.cc
  #     openssl
  #     curl
  #     glib
  #     util-linux
  #     glibc
  #     icu
  #     libunwind
  #     libuuid
  #     zlib
  #     libsecret
  #     # graphical
  #     freetype
  #     mesa
  #     libnotify
  #     SDL2
  #     vulkan-loader
  #     gdk-pixbuf
  #     xorg.libX11
  #   ];
  # };
  systemd = {
    oomd = {
      enableRootSlice = true;
      enableUserServices = true;
    };

    # TODO channels-to-flakes
    tmpfiles.rules = [
      "D /nix/var/nix/profiles/per-user/root 755 root root - -"
    ];
  };

  programs = {
    # type "fuck" to fix the last command that made you go "fuck"
    thefuck.enable = true;
    steam.enable = true;

    # allow users to mount fuse filesystems with allow_other
    fuse.userAllowOther = true;

    # help manage android devices via command line
    adb.enable = true;
  };
}
