{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ bluetooth ];

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
    powerOnBoot = true;
    disabledPlugins = [ "sap" ];
    settings = {
      General = {
        FastConnectable = "true";
        JustWorksRepairing = "always";
        MultiProfile = "multiple";
      };
    };
  };
}
