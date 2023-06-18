{...}: {
  services.syncthing = {
    enable = true;
    user = "will";
    systemService = false;
  };
}
