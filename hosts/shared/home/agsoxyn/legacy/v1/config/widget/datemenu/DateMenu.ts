import PopupWindow from "widget/PopupWindow";
import NotificationColumn from "./NotificationColumn";
import DateColumn from "./DateColumn";
import { settings } from "settings";

type layout =
  | "top"
  | "center"
  | "top-right"
  | "top-center"
  | "top-left"
  | "bottom-left"
  | "bottom-center"
  | "bottom-right";

const { bar, datemenu } = settings;
const pos = bar.position;
const layout = `${bar.position}-${datemenu.position}` as layout;

const Settings = () =>
  Widget.Box({
    class_name: "datemenu horizontal",
    vexpand: false,
    children: [
      NotificationColumn(),
      Widget.Separator({ orientation: 1 }),
      DateColumn(),
    ],
  });

const DateMenu = () =>
  PopupWindow({
    name: "datemenu",
    exclusivity: "exclusive",
    transition: pos === "top" ? "slide_down" : "slide_up",
    layout: layout,
    child: Settings(),
  });

export function setupDateMenu() {
  App.addWindow(DateMenu());
}
