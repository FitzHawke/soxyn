{pkgs, ...}: {
  home.packages = with pkgs; [
    bottles
    gamescope
    mangohud
    ryujinx
    wineWowPackages.wayland
  ];
}
