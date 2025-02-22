import Notifd from "gi://AstalNotifd";
import Bluetooth from "gi://AstalBluetooth";
import Network from "gi://AstalNetwork";
import Wp from "gi://AstalWp";
import Battery from "gi://AstalBattery";
import { bind } from "astal";
import { App, Gtk, hook } from "astal/gtk4";
import { BarButton } from "../BarButton";

export const SystemIndicators = () => {
  const notif = Notifd.get_default();
  const bluetooth = Bluetooth.get_default();
  const network = Network.get_default();
  const audio = Wp.get_default()!.audio;
  const battery = Battery.get_default();

  const DNDIndicator = (
    <image
      visible={bind(notif, "dontDisturb")}
      iconName={"notifications-disabled-symbolic"}
    />
  );

  const BluetoothIndicator = (
    <overlay cssClasses={["bluetooth"]}>
      <image
        visible={bind(bluetooth, "isPowered")}
        iconName={"bluetooth-active-symbolic"}
      />
      <label
        type="overlay"
        halign={Gtk.Align.END}
        valign={Gtk.Align.START}
        label={bind(bluetooth, "devices").as(
          (d) => `${d.filter((c) => c.connected).length}`,
        )}
        visible={bind(bluetooth, "devices").as((d) =>
          d.some((c) => c.connected),
        )}
      />
    </overlay>
  );

  const NetworkIndicator = (
    <box>
      <image
        iconName={bind(network.wifi, "iconName")}
        visible={bind(network, "primary").as((p) => p === 2)}
      />
      <image
        iconName={bind(network.wired, "iconName")}
        visible={bind(network, "primary").as((p) => p !== 2)}
      />
    </box>
  );

  const MicrophoneIndicator = (
    <image iconName={bind(audio.default_microphone, "volume_icon")} />
  );

  const AudioIndicator = (
    <image iconName={bind(audio.default_speaker, "volume_icon")} />
  );

  const BatteryIndicator = (
    <image
      iconName={bind(battery, "battery_icon_name")}
      visible={bind(battery, "is_present")}
    />
  );

  const windowName = "quicksettings";

  return (
    <BarButton
      window={windowName}
      onClicked={() => App.toggle_window(windowName)}
    >
      <box>
        {DNDIndicator}
        {BluetoothIndicator}
        {NetworkIndicator}
        {AudioIndicator}
        {MicrophoneIndicator}
        {BatteryIndicator}
      </box>
    </BarButton>
  );
};
