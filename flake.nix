{
  description = "FitzHawke NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";
    sops-nix.url = "github:mic92/sops-nix";
    nix-colors.url = "github:misterio77/nix-colors";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

    templates.url = github:NixOS/templates;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
      user1 = "will";
    in
    {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      overlays = import ./overlays { inherit inputs outputs; };
      packages = forEachPkgs (pkgs: (import ./pkgs { inherit pkgs; }));

      wallpapers = import ./home/wallpapers;

      nixosConfigurations =
        {
          farosh = mkNixos [ ./hosts/farosh/configuration.nix ];
          dinraal = mkNixos [ ./hosts/dinraal/configuration.nix ];

          naydra = mkNixos [ ./hosts/naydra/configuration.nix ];

          gleeok = mkNixos [ ./hosts/gleeok/configuration.nix ];
          valoo = mkNixos [ ./hosts/valoo/configuration.nix ];
        };
      homeConfigurations =
        {
          "will@farosh" = mkHome [ ./home/farosh.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "will@dinraal" = mkHome [ ./home/dinraal.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "will@naydra" = mkHome [ ./home/naydra.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "will@gleeok" = mkHome [ ./home/gleeok.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "will@valoo" = mkHome [ ./home/valoo.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "will@generic" = mkHome [ ./home/generic.nix ] nixpkgs.legacyPackages."x86_64-linux";
        };
    };
} 
