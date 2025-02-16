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
      child={<box>{child}</box>}
      setup={(self) => {
        let open = false;
        self.cssClasses = ["panel-button"];
        if (window) self.add_css_class(window);

        hook(self, App, (_, win, visible) => {
          if (win !== window) return;

          if (open && !visible) {
            open = false;
            self.remove_css_class("active");
          }

          if (visible) {
            open = true;
            self.add_css_class("active");
          }
        });

        if (setup) setup(self);
      }}
      {...rest}
    />
  );
};
