{ inputs
, pkgs
, config
, ...
}: {
  home.packages = with pkgs; [
    steam
    yuzu
    ryujinx
    mangohud
    bottles
  ];
}
