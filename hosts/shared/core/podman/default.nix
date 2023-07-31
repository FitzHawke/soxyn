{pkgs, ...}: {
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
    extraPackages = with pkgs; [skopeo conmon crun];
  };
}
