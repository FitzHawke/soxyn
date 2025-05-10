{pkgs, ...}: {
  programs.vscode = with pkgs; {
    enable = true;
    package = vscode.fhsWithPackages (pkgs: with pkgs; [libsecret]);
    mutableExtensionsDir = true;
  };

  stylix.targets.vscode.enable = false;
}
