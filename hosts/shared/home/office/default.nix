{pkgs, ...}: {
  home.packages = with pkgs; [
    apostrophe
    errands
    evolution
    file-roller
    gnome-calculator
    gnome-calendar
    gnome-disk-utility
    nautilus
    gnome-text-editor
    libreoffice
  ];
}
