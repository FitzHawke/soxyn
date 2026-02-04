import { clock } from "lib/variables"
import PanelButton from "../PanelButton"
import {settings} from "settings"

const { format, action } = settings.bar.date
const time = Utils.derive([clock], (c) => c.format(format) || "")

export default () => PanelButton({
    window: "datemenu",
    on_clicked: action,
    child: Widget.Label({
        justification: "center",
        label: time.bind(),
    }),
})
