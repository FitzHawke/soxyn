{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    yuzu
    ryujinx
    mangohud
    bottles
  ];
}
