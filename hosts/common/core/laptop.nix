{ pkgs, ... }: {
  systemd.network.wait-online.anyInterface = true;

  services = {
    tlp.enable = true;
    physlock.enable = true;
    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
    };
  };
}
