{ pkgs ? import <nixpkgs> { } }: rec {

  # Packages with an actual source
  rgbdaemon = pkgs.callPackage ./rgbdaemon { };
  shellcolord = pkgs.callPackage ./shellcolord { };
  speedtestpp = pkgs.callPackage ./speedtestpp { };

  # Personal scripts
  primary-xwayland = pkgs.callPackage ./primary-xwayland { };

  # My slightly customized plymouth theme, just makes the blue outline white
  plymouth-spinner-monochrome = pkgs.callPackage ./plymouth-spinner-monochrome { };
}
