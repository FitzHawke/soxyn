# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, ... }: {
  # You can import other NixOS modules here
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./core/bluetooth.nix
    ./core/efi-boot.nix
    ./core/fish.nix
    ./core/greetd.nix
    ./core/hyprland.nix
    ./core/laptop.nix
    ./core/locale.nix
    ./core/nix.nix
    ./core/openssh.nix
    ./core/physical.nix
    ./core/pipewire.nix
    ./core/sops.nix
    ./core/steam-hardware.nix
    ./core/systemd-initrd.nix
  ] ++ (builtins.attrValues outputs.nixosModules);
  
  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  services.greetd.settings.default_session.user = "will";
  
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  environment.enableAllTerminfo = true;
  
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = 524288;
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = 1048576;
    }
  ];
}
