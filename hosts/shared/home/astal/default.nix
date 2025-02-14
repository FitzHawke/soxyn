{
  inputs,
  pkgs,
  # lib,
  # config,
  ...
}: let
  agsoxyn = pkgs.callPackage ./agsoxyn.nix {
    inherit inputs;
  };
in {
  home.packages = [
    agsoxyn
  ];

  # systemd.user.services.agsoxyn = {
  #   Install = {
  #     WantedBy = [config.wayland.systemd.target];
  #   };

  #   Unit = {
  #     ConditionEnvironment = "WAYLAND_DISPLAY";
  #     Description = "agsoxyn desktop";
  #     After = [config.wayland.systemd.target];
  #     PartOf = [config.wayland.systemd.target];
  #   };

  #   Service = {
  #     ExecStart = "${lib.getExe agsoxyn}";
  #     ExecStop = "${lib.getExe agsoxyn} -q";
  #     Restart = "always";
  #     RestartSec = "10";
  #   };
  # };
}
