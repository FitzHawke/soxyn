import PanelButton from "../PanelButton"
import { settings } from "settings"

const { icon, label, action } = settings.bar.launcher

function OSIcon() {
    const child = Widget.Icon({
        icon: icon.icon,
        class_name: `${icon.colored ? "colored" : ""}`,
        css: `
            @keyframes spin {
                to { -gtk-icon-transform: rotate(1turn); }
            }
        `,
    })

    return Widget.Revealer({
        transition: "slide_left",
        child,
        reveal_child: Boolean(icon.icon)
    })
}

export default () => PanelButton({
    window: "launcher",
    on_clicked: action,
    child: Widget.Box([
        OSIcon(),
        Widget.Label({
            class_name: label.colored ? "colored" : "",
            visible: !!label.label,
            label: label.label,
        }),
    ]),
})
