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

  shared = [agenix core bootloader wayland];

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
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # main desktop
  # very much a WIP
  farosh = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "farosh";}
        ./farosh/hardware-configuration.nix
        ./farosh/hardware.nix
        ./farosh/age.nix
        ./farosh/syncthing.nix
        bootloader
        hw.common-cpu-amd
        hw.common-gpu-amd
        # hw.common-pc-ssd
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
  
  # gleeok naydra and valoo are future projects :)
}
