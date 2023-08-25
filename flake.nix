{
  # This file is mainly for setting up overarching configuration
  # like which repositories to use as sources and which architectures to build
  # the configuration for the systems themselves is handled in the hosts directory
  description = "Soxyn configuration";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      # this is the meat and potatoes here, imports ./hosts/default.nix where all the hosts are defined
      flake = {
        nixosConfigurations = import ./hosts inputs;
      };
      # this is a bit of extra config for packages, formatting and a devShell
      perSystem = {
        config,
        system,
        pkgs,
        inputs',
        ...
      }: {
        legacyPackages = import inputs.nixpkgs {
          config.allowUnfree = true;
          config.allowUnsupportedSystem = true;
          inherit system;
        };
        imports = [{_module.args.pkgs = config.legacyPackages;}];

        devShells.default = pkgs.mkShell {
          name = "soxyn";
          packages = with pkgs; [
            nix
            home-manager
            git

            nil
            alejandra

            inputs'.agenix.packages.default
          ];
          NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
          DIRENV_LOG_FORMAT = "";
        };

        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun-nixos-options = {
      url = "github:n3oney/anyrun-nixos-options";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    eww = {
      # url = "github:elkowar/eww";
      # temporarily use ralismarks branch while waiting on sys tray to be merged into upstream
      # https://github.com/elkowar/eww/pull/743
      url = "github:ralismark/eww/tray-3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gross = {
      url = "github:fufexan/gross";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
