import icons from "lib/icons"
import PanelButton from "../PanelButton"
import { settings } from "settings"

const { monochrome, action } = settings.bar.powermenu

export default () => PanelButton({
    window: "powermenu",
    on_clicked: action,
    child: Widget.Icon(icons.powermenu.shutdown),
    setup: self => {
        self.toggleClassName("colored", !monochrome)
        self.toggleClassName("box")
    },
})
