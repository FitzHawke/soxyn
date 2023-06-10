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
    sops-nix.url = "github:mic92/sops-nix";

    templates.url = github:NixOS/templates;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      mkNixos = modules: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit modules;
        specialArgs = { inherit inputs; };
      };
      mkHome = modules: pkgs: home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = { inherit inputs; };
      };
      sops.secrets.user1name = { sopsFile = ./users/secrets.yaml; };
      user1 = config.sops.secrets.user1name.path;
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
          "${user1}@farosh" = mkHome [ ./home/farosh.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "${user1}@dinraal" = mkHome [ ./home/dinraal.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "${user1}@naydra" = mkHome [ ./home/naydra.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "${user1}@gleeok" = mkHome [ ./home/gleeok.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "${user1}@valoo" = mkHome [ ./home/valoo.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "${user1}@generic" = mkHome [ ./home/generic.nix ] nixpkgs.legacyPackages."x86_64-linux";
        };
    };
} 
