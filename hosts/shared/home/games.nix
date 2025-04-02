{pkgs, ...}: {
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
    ryubing
    torzu
    winetricks
    wineWowPackages.wayland
  ];
}
