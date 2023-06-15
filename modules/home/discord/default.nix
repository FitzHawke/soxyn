{ config
, pkgs
, inputs
, ...
}: {
  home.packages = [
    pkgs.webcord
    pkgs.discord
  ];
}
