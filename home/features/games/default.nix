{ pkgs, ... }: {
  imports = [
    ./bottles.nix
    ./steam.nix
    ./yuzu.nix
  ];
  home.packages = with pkgs; [ gamescope ];
}
