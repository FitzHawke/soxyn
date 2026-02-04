import { App, hook } from "astal/gtk4";
import { ButtonProps } from "astal/gtk4/widget";

type BarButtonProps = ButtonProps & {
  window?: string;
};

export const BarButton = ({
  window = "",
  child,
  setup,
  ...rest
}: BarButtonProps) => {
  return (
    <button
      focusable={false}
      setup={(self) => {
        let open = false;
        self.add_css_class("bar-button");
        if (window) self.add_css_class(window);

        hook(self, App, "window-toggled", (_, win) => {
          if (win.name !== window) return;

          if (open && !win.visible) {
            open = false;
            self.remove_css_class("active");
          }

          if (win.visible) {
            open = true;
            self.add_css_class("active");
          }
        });

        if (setup) setup(self);
      }}
      {...rest}
    >
      {child}
    </button>
  );
};
