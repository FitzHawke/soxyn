import { App } from "astal/gtk4";
import style from "./style/style.scss";
import { Bar } from "@widgets/bar/Bar";
import { Launcher } from "@widgets/launcher/Launcher";
import { PowerMenu } from "@widgets/powermenu/PowerMenu";
import { Confirmation } from "@widgets/powermenu/Confirmation";

App.start({
  instanceName: "agsoxyn",
  css: style,
  icons: "./assets",
  main: () => [
    ...App.get_monitors().map(Bar),
    Launcher(),
    PowerMenu(),
    Confirmation(),
  ],
});
