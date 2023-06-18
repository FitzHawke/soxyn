{ pkgs , ...}: {
  services = {
    gvfs.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      gnome-online-accounts.enable = true;
      gnome-keyring.enable = true;
    };
  };
  programs.dconf.enable= true;

  home.packages = with pkgs; [
    evolution
    gnome.gnome-calculator
    gnome.gnome-calendar
    gnome.nautilus
  ];
}