import PopupWindow from "widget/PopupWindow";
import powermenu, { type Action } from "service/powermenu";
import icons from "lib/icons";
import { settings } from "settings";
import type Gtk from "gi://Gtk?version=3.0";

const { layout, labels } = settings.powermenu;

const SysButton = (action: Action, label: string) =>
  Widget.Button({
    on_clicked: () => powermenu.action(action),
    child: Widget.Box({
      vertical: true,
      class_name: "system-button",
      children: [
        Widget.Icon(icons.powermenu[action]),
        Widget.Label({
          label,
          visible: labels,
        }),
      ],
    }),
  });

export default () =>
  PopupWindow({
    name: "powermenu",
    transition: "crossfade",
    child: Widget.Box<Gtk.Widget>({
      class_name: "powermenu horizontal",
      setup: (self) => {
        self.toggleClassName("box", layout === "box");
        self.toggleClassName("line", layout === "line");
      },
      children:
        layout === "line"
          ? [
              SysButton("shutdown", "Shutdown"),
              SysButton("logout", "Log Out"),
              SysButton("reboot", "Reboot"),
              SysButton("sleep", "Sleep"),
            ]
          : [
              Widget.Box(
                { vertical: true },
                SysButton("shutdown", "Shutdown"),
                SysButton("logout", "Log Out")
              ),
              Widget.Box(
                { vertical: true },
                SysButton("reboot", "Reboot"),
                SysButton("sleep", "Sleep")
              ),
            ],
    }),
  });
