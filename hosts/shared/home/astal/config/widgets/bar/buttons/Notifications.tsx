import Notifd from "gi://AstalNotifd";
import { App } from "astal/gtk4";
import { BarButton } from "../BarButton";
import { bind } from "astal";

export const Notifications = () => {
  const notifd = Notifd.get_default();
  const notifs = bind(notifd, "notifications");
  const windowName = "datemenu";
  return (
    <BarButton
      window={windowName}
      cssClasses={["messages"]}
      onClicked={() => App.toggle_window(windowName)}
      visible={notifs.as((n) => n.length > 0)}
    >
      <box>
        <image iconName={"view-app-grid-symbolic"} />
        <label label={"Apps"} />
      </box>
    </BarButton>
  );
};
