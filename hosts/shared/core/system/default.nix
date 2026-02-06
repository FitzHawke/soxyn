{
  pkgs,
  lib,
  ...
}: {
  services = {
    dbus = {
      implementation = "broker";
      packages = with pkgs; [dconf gcr udisks2];
      enable = true;
    };
    udev.packages = with pkgs; [gnome-settings-daemon];
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
    udisks2.enable = true;
  };

  programs = {
    dconf.enable = true;
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    # allow users to mount fuse filesystems with allow_other
    fuse.userAllowOther = true;
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
    appimage-run
    hunspellDicts.en_US
    hunspellDicts.en_CA
    android-tools
  ];

  time = {
    timeZone = "America/Toronto";
    hardwareClockInLocalTime = false;
  };
  hardware.ledger.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

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

  systemd = {
    oomd = {
      enableRootSlice = true;
      enableUserSlices = true;
    };

    # TODO channels-to-flakes
    tmpfiles.rules = [
      "D /nix/var/nix/profiles/per-user/root 755 root root - -"
    ];
  };
}
