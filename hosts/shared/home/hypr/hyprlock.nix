{...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      input-field = {
        size = "200, 50";
        outline_thickness = 3;
        dots_size = 0.33;
        dots_spacing = 0.15;
        dots_center = false;
        dots_rounding = -1;
        fade_on_empty = true;
        fade_timeout = 1000;
        placeholder_text = "<i>Input Password...</i>";
        hide_input = false;
        rounding = -1;
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        fail_transition = 300;
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1;
        invert_numlock = false;

        position = "0, -20";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          text = "$TIME";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 50;
          font_family = "Noto Sans";

          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
