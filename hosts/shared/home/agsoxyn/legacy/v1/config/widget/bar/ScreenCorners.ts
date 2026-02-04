import { settings } from "settings";

const { corners } = settings.bar;

export default (monitor: number) =>
  Widget.Window({
    monitor,
    name: `corner${monitor}`,
    class_name: "screen-corner",
    anchor: ["top", "bottom", "right", "left"],
    click_through: true,
    child: Widget.Box({
      class_name: "shadow",
      child: Widget.Box({
        class_name: "border",
        expand: true,
        child: Widget.Box({
          class_name: "corner",
          expand: true,
        }),
      }),
    }),
    setup: (self) => self.toggleClassName("corners", corners),
  });
