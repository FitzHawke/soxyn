{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  core = ./shared/core;
  gamemode = ./shared/core/gamemode;
  users = ./shared/users;
  wayland = ./shared/meta/wayland;
  agenix = inputs.agenix.nixosModules.default;
  hyprland = inputs.hyprland.nixosModules.default;
  hw = inputs.nixos-hardware.nixosModules;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [agenix core users];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.will = ./shared/home;
  };
in {
  # all my hosts are named after zelda characters and creatures

  # laptop
  dinraal = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "dinraal";}
        ./by-id/dinraal/hardware-configuration.nix
        ./by-id/dinraal/hardware.nix
        ./by-id/dinraal/age.nix
        ./by-id/dinraal/syncthing.nix
        hw.common-cpu-intel
        hw.common-pc-laptop
        gamemode
        hyprland
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
        ./by-id/farosh/hardware-configuration.nix
        ./by-id/farosh/hardware.nix
        ./by-id/farosh/age.nix
        ./by-id/farosh/syncthing.nix
        hw.common-cpu-amd
        hw.common-gpu-amd
        gamemode
        hyprland
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # generic image WIP
  korok = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "farosh";}
        ./by-id/korok/hardware-configuration.nix
        ./by-id/korok/hardware.nix
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # NAS/server WIP not tested or in use yet
  naydra = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "naydra";}
        ./by-id/naydra/hardware-configuration.nix
        ./by-id/naydra/hardware.nix
        ./by-id/naydra/syncthing.nix
        hw.common-cpu-intel
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # Dedi server. WIP, not tested or in use yet
  gleeok = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "gleeok";}
        ./by-id/gleeok/hardware-configuration.nix
        ./by-id/gleeok/hardware.nix
        ./by-id/gleeok/syncthing.nix
        hw.common-cpu-intel
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
  
  # valoo will be a future project :)
}
