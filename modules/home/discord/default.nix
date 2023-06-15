{ pkgs
, ...
}: {
  home.packages = [
    pkgs.webcord
    pkgs.discord
  ];
}
