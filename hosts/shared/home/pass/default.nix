{ pkgs, ...}:

{
  home.packages = with pkgs; [
    bitwarden
    keepassxc
    rbw
  ];
}