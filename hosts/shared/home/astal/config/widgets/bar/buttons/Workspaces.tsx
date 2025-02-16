import Hyprland from "gi://AstalHyprland";
import { range } from "@lib/utils";
import { BarButton } from "../BarButton";
import { Gtk, hook } from "astal/gtk4";

export const Workspaces = () => {
  const hypr = Hyprland.get_default();

  const onScroll = (_: Gtk.Button, _dx: number, dy: number) => {
    if (dy > 0) hypr.dispatch("workspace", "m+1");
    else if (dy < 0) hypr.dispatch("workspace", "m-1");
  };

  const Workspace = (ws: number) => {
    return (
      <box
        children={range(ws).map((i) => (
          <label
            label={String(i)}
            valign={Gtk.Align.CENTER}
            setup={(self) =>
              hook(self, hypr, () => {
                hypr.focused_workspace.id === i
                  ? self.add_css_class("active")
                  : self.remove_css_class("active");
                (hypr.get_workspace(i)?.clients.length || 0) > 0
                  ? self.add_css_class("occupied")
                  : self.remove_css_class("occupied");
              })
            }
          />
        ))}
      />
    );
  };

  return BarButton({
    cssClasses: ["workspaces"],
    onScroll: onScroll,
    child: Workspace(10),
  });
};
