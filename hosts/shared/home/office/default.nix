{pkgs, ...}: {
  home.packages = with pkgs; [
    evolution
    gnome.file-roller
    gnome.gnome-calculator
    gnome.gnome-calendar
    gnome.nautilus
    gnome-text-editor
    libreoffice-fresh
  ];
}
