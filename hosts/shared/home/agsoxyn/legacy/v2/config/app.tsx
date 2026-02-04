import app from "ags/gtk4/app";
import { createBinding, For, This } from "ags";
import style from "./style/style.scss";
import { Bar } from "@widgets/bar/Bar";
import { Launcher } from "@widgets/launcher/Launcher";
import { PowerMenu } from "@widgets/powermenu/PowerMenu";
import { Confirmation } from "@widgets/powermenu/Confirmation";

app.start({
  instanceName: "agsoxyn",
  css: style,
  icons: "./assets",
  main() {
    const monitors = createBinding(app, "monitors");
    return [
      <For each={monitors}>
        {(monitor) => (
          <This this={app}>
            <Bar gdkmonitor={monitor} />
          </This>
        )}
      </For>,
      <Launcher />,
      <PowerMenu />,
      <Confirmation />,
    ];
  },
});

// App.config({
//   onConfigParsed: () => {
//     setupQuickSettings();
//     setupDateMenu();
//     init();
//   },
//   closeWindowDelay: {
//     launcher: settings.transition,
//     overview: settings.transition,
//     quicksettings: settings.transition,
//     datemenu: settings.transition,
//   },
//   windows: () => [
//     ...forMonitors(Bar),
//     ...forMonitors(NotificationPopups),
//     ...forMonitors(ScreenCorners),
//     ...forMonitors(OSD),
//     Launcher(),
//     Overview(),
//     PowerMenu(),
//     SettingsDialog(),
//     Verification(),
//   ],
// });
