{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.system}.proton-ge
    bottles
    gamescope
    mangohud
    ryujinx
    steam
    wineWowPackages.wayland
    yuzu
  ];

  environment.variables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${inputs.nix-gaming.packages.${pkgs.system}.proton-ge}";
}
