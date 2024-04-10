import icons from "lib/icons"
import { settings } from "settings"
import PanelButton from "../PanelButton"

const battery = await Service.import("battery")
const { bar, percentage, blocks, width, low } = settings.bar.battery

const Indicator = () => Widget.Icon({
    setup: self => self.hook(battery, () => {
        self.icon = battery.charging || battery.charged
            ? icons.battery.charging
            : battery.icon_name
    }),
})

const PercentLabel = () => Widget.Revealer({
    transition: "slide_right",
    click_through: true,
    reveal_child: percentage,
    child: Widget.Label({
        label: battery.bind("percent").as(p => `${p}%`),
    }),
})

const LevelBar = () => {
    const level = Widget.LevelBar({
        bar_mode: "discrete",
        max_value: blocks,
        visible: bar !== "hidden",
        value: battery.bind("percent").as(p => (p / 100) * blocks),
        css: `block { min-width: ${width / blocks}pt; }`,
    })
    return level
}

const WholeButton = () => Widget.Overlay({
    vexpand: true,
    child: LevelBar(),
    class_name: "whole",
    pass_through: true,
    overlay: Widget.Box({
        hpack: "center",
        children: [
            Widget.Icon({
                icon: icons.battery.charging,
                visible: Utils.merge([
                    battery.bind("charging"),
                    battery.bind("charged"),
                ], (ing, ed) => ing || ed),
            }),
            Widget.Box({
                hpack: "center",
                vpack: "center",
                child: PercentLabel(),
            }),
        ],
    }),
})

const Regular = () => Widget.Box({
    class_name: "regular",
    children: [
        Indicator(),
        PercentLabel(),
        LevelBar(),
    ],
})

const buttonStyle = bar === "whole" ? WholeButton() : Regular()

export default () => PanelButton({
    class_name: "battery-bar",
    hexpand: false,
    visible: battery.bind("available"),
    // @ts-ignore
    child: Widget.Box({
        expand: true,
        visible: battery.bind("available"),
        child: buttonStyle,
    }),
    setup: self => self
        .hook(battery, w => {
            w.toggleClassName("charging", battery.charging || battery.charged)
            w.toggleClassName("low", battery.percent < low)
        }),
})
