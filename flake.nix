{
  description = "FitzHawke NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github.com:hyprwm/hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";
    sops-nix.url = "github:mic92/sops-nix";
    nix-colors.url = "github:misterio77/nix-colors";

    templates.url = github:NixOS/templates;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, home-manager, config, ... }@inputs:
    let
      inherit (self) outputs;
      forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});

      mkNixos = modules: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit modules;
        specialArgs = { inherit inputs outputs; };
      };
      mkHome = modules: pkgs: home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = { inherit inputs outputs; };
      };
      sops.secrets.user1name = { sopsFile = ./users/secrets.yaml; };
      user1 = "$__file{${config.sops.secrets.user1-name.path}}";
    in
    {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      overlays = import ./overlays { inherit inputs outputs; };
      packages = forEachPkgs (pkgs: (import ./pkgs { inherit pkgs; }));

      wallpapers = import ./home/wallpapers;

      nixosConfigurations =
        {
          farosh = mkNixos [ ./hosts/farosh ];
          dinraal = mkNixos [ ./hosts/dinraal ];

          naydra = mkNixos [ ./hosts/naydra ];

          gleeok = mkNixos [ ./hosts/gleeok ];
          valoo = mkNixos [ ./hosts/valoo ];
        };
      homeConfigurations =
        {
          "${user1}@farosh" = mkHome [ ./home/farosh.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "${user1}@dinraal" = mkHome [ ./home/dinraal.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "${user1}@naydra" = mkHome [ ./home/naydra.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "${user1}@gleeok" = mkHome [ ./home/gleeok.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "${user1}@valoo" = mkHome [ ./home/valoo.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "${user1}@generic" = mkHome [ ./home/generic.nix ] nixpkgs.legacyPackages."x86_64-linux";
        };
    };
} 
