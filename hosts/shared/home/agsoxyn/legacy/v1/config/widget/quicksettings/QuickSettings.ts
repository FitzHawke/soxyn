import type Gtk from "gi://Gtk?version=3.0";
import { Header } from "./widgets/Header";
import { Volume, Microhone, SinkSelector, AppMixer } from "./widgets/Volume";
import { Brightness } from "./widgets/Brightness";
import { NetworkToggle, WifiSelection } from "./widgets/Network";
import { BluetoothToggle, BluetoothDevices } from "./widgets/Bluetooth";
import { DND } from "./widgets/DND";
import { MicMute } from "./widgets/MicMute";
import { Media } from "./widgets/Media";
import PopupWindow from "widget/PopupWindow";
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

const { bar, quicksettings } = settings;
const media = (await Service.import("mpris")).bind("players");
const layout = `${bar.position}-${quicksettings.position}` as layout;

const Row = (
  toggles: Array<() => Gtk.Widget> = [],
  menus: Array<() => Gtk.Widget> = []
) =>
  Widget.Box({
    vertical: true,
    children: [
      Widget.Box({
        homogeneous: true,
        class_name: "row horizontal",
        children: toggles.map((w) => w()),
      }),
      ...menus.map((w) => w()),
    ],
  });

const Settings = () =>
  Widget.Box({
    vertical: true,
    class_name: "quicksettings vertical",
    css: `min-width: ${quicksettings.width}px;`,
    children: [
      Header(),
      Widget.Box({
        class_name: "sliders-box vertical",
        vertical: true,
        children: [
          Row([Volume], [SinkSelector, AppMixer]),
          Microhone(),
          Brightness(),
        ],
      }),
      Row([NetworkToggle, BluetoothToggle], [WifiSelection, BluetoothDevices]),
      Row([MicMute, DND]),
      Widget.Box({
        visible: media.as((l) => l.length > 0),
        child: Media(),
      }),
    ],
  });

const QuickSettings = () =>
  PopupWindow({
    name: "quicksettings",
    exclusivity: "exclusive",
    transition: bar.position === "top" ? "slide_down" : "slide_up",
    layout: layout,
    child: Settings(),
  });

export function setupQuickSettings() {
  App.addWindow(QuickSettings());
}
