import { type Client } from "types/service/hyprland";
import { createSurfaceFromWidget, icon } from "lib/utils";
import Gdk from "gi://Gdk";
import Gtk from "gi://Gtk?version=3.0";
import { settings } from "settings";
import icons from "lib/icons";

const m = settings.overview.monochromeIcon;
const TARGET = [Gtk.TargetEntry.new("text/plain", Gtk.TargetFlags.SAME_APP, 0)];
const hyprland = await Service.import("hyprland");
const apps = await Service.import("applications");
const dispatch = (args: string) => hyprland.messageAsync(`dispatch ${args}`);

export default ({ address, size: [w, h], class: c, title }: Client) => {
  const app = apps.list.find((app) => app.match(c));
  const curIcon = !app
    ? icons.fallback.executable + (m ? "-symbolic" : "")
    : icon(
        app.icon_name + (m ? "-symbolic" : ""),
        icons.fallback.executable + (m ? "-symbolic" : "")
      );

  return Widget.Button({
    class_name: "client",
    attribute: { address },
    tooltip_text: `${title}`,
    child: Widget.Icon({
      css: `
            min-width: ${(settings.overview.scale / 100) * w}px;
            min-height: ${(settings.overview.scale / 100) * h}px;
        `,
      // typescript take issue if I don't wrap with literals for reasons I don't fully understand
      icon: curIcon,
    }),
    on_secondary_click: () => dispatch(`closewindow address:${address}`),
    on_clicked: () => {
      dispatch(`focuswindow address:${address}`);
      App.closeWindow("overview");
    },
    setup: (btn) =>
      btn
        .on("drag-data-get", (_w, _c, data) =>
          data.set_text(address, address.length)
        )
        .on("drag-begin", (_, context) => {
          Gtk.drag_set_icon_surface(context, createSurfaceFromWidget(btn));
          btn.toggleClassName("hidden", true);
        })
        .on("drag-end", () => btn.toggleClassName("hidden", false))
        .drag_source_set(
          Gdk.ModifierType.BUTTON1_MASK,
          TARGET,
          Gdk.DragAction.COPY
        ),
  });
};
