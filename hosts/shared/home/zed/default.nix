{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      # https://github.com/zed-industries/zed/tree/main/extensions
      "html"
      "toml"
      "emmet"

      # https://github.com/zed-industries/extensions/tree/main/extensions
      "catppuccin"
      "git-firefly"
      "xml"
      "svelte"
      "scss"
      "astro"
      "nix"
      "basher"
      "typos"
    ];
    # extraPackages = with pkgs; [
    #   package-version-server
    #   typos
    # ];
  };
}
