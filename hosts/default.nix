{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  wayland = ../modules/wayland;
  agenix = inputs.agenix.nixosModules.default;
  hw = inputs.nixos-hardware.nixosModules;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [agenix core bootloader];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.will = ../modules/home;
  };
in {
  # all my hosts are named after zelda creatures btw

  # laptop
  dinraal = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "dinraal";}
        ./dinraal/hardware-configuration.nix
        ./dinraal/hardware.nix
        ./dinraal/age.nix
        ./dinraal/syncthing.nix
        hw.common-cpu-intel
        hw.common-pc-laptop
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # main desktop
  farosh = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "farosh";}
        ./farosh/hardware-configuration.nix
        ./farosh/hardware.nix
        ./farosh/age.nix
        ./farosh/syncthing.nix
        hw.common-cpu-amd
        hw.common-gpu-amd
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

    naydra = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "naydra";}
        ./naydra/hardware-configuration.nix
        ./naydra/hardware.nix
        ./naydra/syncthing.nix
        bootloader
        hw.common-cpu-intel
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
  
  # gleeok naydra and valoo are future projects :)
}
