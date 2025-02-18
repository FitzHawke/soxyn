import Tray from "gi://AstalTray";
import { bind } from "astal";

export const SysTray = () => {
  const tray = Tray.get_default();

  const SysTrayItem = (item: Tray.TrayItem) => (
    <menubutton
      cssClasses={["tray-item"]}
      tooltipMarkup={bind(item, "tooltipMarkup")}
      menuModel={bind(item, "menuModel")}
    >
      <image gicon={bind(item, "gicon")} />
    </menubutton>
  );
  return (
    <box children={bind(tray, "items").as((items) => items.map(SysTrayItem))} />
  );
};
