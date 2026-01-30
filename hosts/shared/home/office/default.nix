{pkgs, ...}: {
  home.packages = with pkgs; [
    apostrophe
    calibre
    curtail
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
