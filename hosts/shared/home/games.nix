{pkgs,  ...}: {

  # imports = [/home/will/workspaces/notSoxyn/factorio.nix];

  # Lazy secrets management. Needed at buildtime and I dont know how to do that with agenix...
  # requires --impure flag to build

  ####### Imported file contents
  # {pkgs, ...}: {
  #   home.packages = with pkgs; [
  #     (factorio-space-age.override {
  #       username = "Kangaroo";
  #       token = "aBunch0fNumb3rsAndLetters02541";
  #     })
  #   ];
  # }

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
