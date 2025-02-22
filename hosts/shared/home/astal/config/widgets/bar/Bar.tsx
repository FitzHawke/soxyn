import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import { Launcher } from "./buttons/Launcher";
import { Workspaces } from "./buttons/Workspaces";
import { Taskbar } from "./buttons/Taskbar";
import { Notifications } from "./buttons/Notifications";
import { DateTime } from "./buttons/DateTime";
import { Media } from "./buttons/Media";
import { SysTray } from "./buttons/SysTray";
import { ColourPicker } from "./buttons/ColourPicker";
import { PowerMenu } from "./buttons/PowerMenu";
import { SystemIndicators } from "./buttons/SystemIndicators";

export function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;
  const Expander = () => <box hexpand={true} />;

  return (
    <window
      visible
      cssClasses={["bar"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox>
        <box hexpand={true}>
          {Launcher()}
          {Workspaces()}
          {Taskbar()}
          {Expander()}
          {Notifications()}
        </box>
        <box halign={Gtk.Align.CENTER}>{DateTime()}</box>
        <box hexpand={true}>
          {Media()}
          {Expander()}
          {SysTray()}
          {ColourPicker()}
          {SystemIndicators()}
          {PowerMenu()}
        </box>
      </centerbox>
    </window>
  );
}
