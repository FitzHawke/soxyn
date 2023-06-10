{
  description = "FitzHawke NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      mkNixos = modules: nixpkgs.lib.nixosSystem {
        inherit modules;
        specialArgs = { inherit inputs; };
      };
      mkHome = modules: pkgs: home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = { inherit inputs; };
      };
    in
    {
      nixosConfigurations = {
        farosh = mkNixos [ ./hosts/farosh ];
        dinraal = mkNixos [ ./hosts/dinraal ];

        naydra = mkNixos [ ./hosts/naydra ];

        gleeok = mkNixos [ ./hosts/gleeok ];
        valoo = mkNixos [ ./hosts/valoo ];
      };
      homeConfigurations =
        {
          "fitz@farosh" = mkHome [ ./home/fitz/farosh.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "fitz@dinraal" = mkHome [ ./home/fitz/dinraal.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "fitz@naydra" = mkHome [ ./home/fitz/naydra.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "fitz@gleeok" = mkHome [ ./home/fitz/gleeok.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "fitz@valoo" = mkHome [ ./home/fitz/valoo.nix ] nixpkgs.legacyPackages."x86_64-linux";
          "fitz@generic" = mkHome [ ./home/fitz/generic.nix ] nixpkgs.legacyPackages."x86_64-linux";
        };
    };
} 
