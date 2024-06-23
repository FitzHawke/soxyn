{pkgs, ...}: {
  home.packages = with pkgs; [
    gamescope
    lutris
    mangohud
    ryujinx
    winetricks
    wineWowPackages.wayland
  ];

  # Terraria tmodloader dotnet install
  # Need to change version in tmodloader.runtime.config to match dotnet core version
  # can be found at [dotnet root]/shared/Microsoft.NETCore.app/8.0.6
  xdg.dataFile."Steam/steamapps/common/tModLoader/dotnet".source = pkgs.dotnet-sdk_8;
}
