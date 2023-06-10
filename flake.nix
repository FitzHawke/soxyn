{
  description = "FitzHawke NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github.com:hyprwm/hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";

    templates.url = github:NixOS/templates;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      mkNixos = modules: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit modules;
        specialArgs = { inherit inputs; };
      };
      mkHome = modules: pkgs: home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = { inherit inputs; };
      };
    in
    {
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        farosh = mkNixos [ ./hosts/farosh ];
        dinraal = mkNixos [ ./hosts/dinraal ];

        naydra = mkNixos [ ./hosts/naydra ];

        gleeok = mkNixos [ ./hosts/gleeok ];
        valoo = mkNixos [ ./hosts/valoo ];
      };
      homeConfigurations =
        {
          "fitz@farosh" = mkHome [ ./home/farosh.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "fitz@dinraal" = mkHome [ ./home/dinraal.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "fitz@naydra" = mkHome [ ./home/naydra.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "fitz@gleeok" = mkHome [ ./home/gleeok.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "fitz@valoo" = mkHome [ ./home/valoo.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "fitz@generic" = mkHome [ ./home/generic.nix ] nixpkgs.legacyPackages."x86_64-linux";
        };
    };
} 
