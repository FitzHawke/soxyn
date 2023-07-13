{pkgs, ...}: {
  home.packages = with pkgs; [
    evolution
    gnome.file-roller
    gnome.gnome-calculator
    gnome.gnome-calendar
    gnome.nautilus
    libreoffice-fresh
    thunderbird
  ];
}