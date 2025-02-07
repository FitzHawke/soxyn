{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./fonts.nix
    ./services.nix
    ./pipewire.nix
    ./hyprland.nix
  ];

  environment = {
    variables = {
      NIXOS_OZONE_WL = "1";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      DISABLE_QT5_COMPAT = "0";
      GDK_BACKEND = "wayland";
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      WLR_DRM_NO_ATOMIC = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_STYLE_OVERRIDE = "kvantum";
      MOZ_ENABLE_WAYLAND = "1";
      # WLR_BACKEND = "vulkan";
      # WLR_RENDERER = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";
      XDG_SESSION_TYPE = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
    };
    systemPackages = [inputs.umu.packages.${pkgs.system}.default];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services = {
    upower.enable = true;
    gvfs.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      gnome-online-accounts.enable = true;
      gnome-keyring.enable = true;
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin.steamcompattool
    ];
  };
}
