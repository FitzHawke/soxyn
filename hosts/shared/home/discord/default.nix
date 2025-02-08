{pkgs, ...}: {
  home.packages = with pkgs; [
    dissent

    # may need to run once without OpenASAR and Vencord after update
    # openASAR appears to not download something discord needs
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}
