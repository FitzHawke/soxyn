{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.system}.proton-ge
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge
    bottles
    gamescope
    mangohud
    ryujinx
    steam
    yuzu
  ];
}
