{pkgs, ...}: {
  home.packages = with pkgs; [
    grimblast # screenshots
  ];

  imports = [
    ./binds.nix
    ./monitors.nix
    ./rules.nix
    ./settings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
