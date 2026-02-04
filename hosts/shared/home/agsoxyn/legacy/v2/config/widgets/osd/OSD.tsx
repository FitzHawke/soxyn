import { WindowFrame } from "@widgets/windows/WindowFramework";
import { App, Astal, Gdk, Gtk } from "astal/gtk4";

export const OnScreenDisplay = (gdkmonitor: Gdk.Monitor) => {
  return (
    <WindowFrame
      name={"osd"}
      gdkmonitor={gdkmonitor}
      layer={Astal.Layer.OVERLAY}
      canFocus={false}
      canTarget={false}
      application={App}
      marginRequest={20}
      hLoc={1}
      transition={Gtk.RevealerTransitionType.SWING_LEFT}
    >
      <box></box>
    </WindowFrame>
  );
};
