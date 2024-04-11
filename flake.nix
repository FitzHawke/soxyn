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
            # basics -- should already be available on systems running soxyn
            nix
            home-manager
            git

            # nix lsp and formatting
            nil
            alejandra

            # secrets management
            inputs'.agenix.packages.default

            # packages for ags development
            bun
            nodePackages.typescript
            nodePackages.typescript-language-server
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
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    eww = {
      url = "github:elkowar/eww";
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
    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
