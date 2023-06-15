{ config
, pkgs
, inputs
, ...
}:
let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "discord";
    rev = "ae347ffdc78048915441e97ac0e5c1ab06dd2fe5";
    sha256 = "1l310j35781k150362sprf0js3i0y03xw9as75l74v69mxc01x3p";
  };

  theme = "${catppuccin}/themes/mocha.theme.css";
in
{
  home.packages = [
    (inputs.webcord.packages.${pkgs.system}.default.override {
      flags = [ "--add-css-theme=${theme}" ];
    })
  ];
}
