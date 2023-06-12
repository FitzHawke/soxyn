{ lib
, pkgs
, ...
}: {
  environment.systemPackages = with pkgs; [ pulseaudio pulsemixer ];
  sound.enable = false; # ALSA
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  systemd.user.services = {
    pipewire.wantedBy = [ "default.target" ];
    pipewire-pulse = {
      path = [ pkgs.pulseaudio ];
      wantedBy = [ "default.target" ];
    };
  };
}

