import { createBinding, For, This } from "ags"
import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./widget/bar/Bar"
import { Launcher } from "./widget/launcher/Launcher"

app.start({
  css: style,
  gtkTheme: "Adwaita",
  instanceName: "agsoxyn",
  main() {
    const monitors = createBinding(app, "monitors")

    return [
      <For each={monitors}>
        {(monitor) => (
          <This this={app}>
            <Bar gdkmonitor={monitor} />
          </This>
        )}
      </For>,
      <Launcher />,
      // <PowerMenu />,
      // <Confirmation />,
    ]
  },
})
