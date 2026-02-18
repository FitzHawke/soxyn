import { createBinding, For, This } from "ags"
import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./widget/bar/Bar"
import { Launcher } from "./widget/launcher/Launcher"

app.start({
  css: style,
  gtkTheme: "Adwaita",
  instanceName: "agsoxyn",

  requestHandler(argv: string[]) {
    const [cmd, ...rest] = argv
    if (cmd == "quit") {
      app.quit()
    } else if (cmd == "launcher") {
      app.toggle_window("launcher")
    } else if (cmd == "powermenu") {
      app.toggle_window("powermenu")
    }
  },

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
