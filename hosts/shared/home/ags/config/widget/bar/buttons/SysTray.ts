import { type TrayItem } from "types/service/systemtray"
import PanelButton from "../PanelButton"
import Gdk from "gi://Gdk"
import { settings } from "settings"

const systemtray = await Service.import("systemtray")
const { ignore } = settings.bar.systray

const SysTrayItem = (item: TrayItem) => PanelButton({
    class_name: "tray-item",
    child: Widget.Icon({ icon: item.bind("icon") }),
    tooltip_markup: item.bind("tooltip_markup"),
    setup: self => {
        const menu = item.menu
        if (!menu)
            return

        const id = item.menu?.connect("popped-up", () => {
            self.toggleClassName("active")
            menu.connect("notify::visible", () => {
                self.toggleClassName("active", menu.visible)
            })
            menu.disconnect(id!)
        })

        if (id)
            self.connect("destroy", () => item.menu?.disconnect(id))
    },

    on_primary_click: btn => item.menu?.popup_at_widget(
        btn, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null),

    on_secondary_click: btn => item.menu?.popup_at_widget(
        btn, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null),
})

export default () => Widget.Box()
    .bind("children", systemtray, "items", i => i
        .filter(({ id }) => !ignore.includes(id))
        .map(SysTrayItem))
