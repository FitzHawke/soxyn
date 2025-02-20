import Hyprland from "gi://AstalHyprland";
import { range } from "@lib/utils";
import { BarButton } from "../BarButton";
import { App, Gtk, hook } from "astal/gtk4";

export const Workspaces = () => {
  const hypr = Hyprland.get_default();

  const onScroll = (_: Gtk.Button, _dx: number, dy: number) => {
    if (dy > 0) hypr.dispatch("workspace", "m+1");
    else if (dy < 0) hypr.dispatch("workspace", "m-1");
  };

  const Workspace = ({ ws }: { ws: number }) => (
    <box>
      {range(ws).map((i) => (
        <label
          label={String(i)}
          valign={Gtk.Align.CENTER}
          setup={(self) =>
            hook(self, hypr, "event", () => {
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
    </box>
  );

  const windowName = "overview";

  return (
    <BarButton
      window={windowName}
      cssClasses={["workspaces"]}
      onScroll={onScroll}
      onClicked={() => App.toggle_window(windowName)}
    >
      <Workspace ws={10} />
    </BarButton>
  );
};
