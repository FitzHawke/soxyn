{pkgs, ...}: {
  home.packages = with pkgs; [
    evolution
    file-roller
    gnome-calculator
    gnome-calendar
    gnome-disk-utility
    nautilus
    gnome-text-editor
    libreoffice-fresh
  ];
}
