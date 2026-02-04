import icons from "lib/icons"
import PanelButton from "../PanelButton"
import { settings } from "settings"

const n = await Service.import("notifications")
const notifs = n.bind("notifications")
const action = settings.bar.messages.action

export default () => PanelButton({
    class_name: "messages",
    on_clicked: action,
    visible: notifs.as(n => n.length > 0),
    child: Widget.Box([
        Widget.Icon(icons.notifications.message),
    ]),
})
