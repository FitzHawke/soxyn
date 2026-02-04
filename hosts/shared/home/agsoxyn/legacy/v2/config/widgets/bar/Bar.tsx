import app from "ags/gtk4/app";
import { Astal, Gtk, Gdk } from "ags/gtk4";
import { onCleanup } from "ags";
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

export function Bar({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) {
  let win: Astal.Window;
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;
  const Expander = () => <box hexpand={true} />;

  onCleanup(() => win.destroy());

  return (
    <window
      $={(self) => (win = self)}
      visible
      cssClasses={["bar"]}
      name={`bar-${gdkmonitor.connector}`}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
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
