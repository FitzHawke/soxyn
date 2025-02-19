import { App } from "astal/gtk4";
import { BarButton } from "../BarButton";

export const PowerMenu = () => {
  const windowName = "powermenu";
  return (
    <BarButton
      window={windowName}
      onClicked={() => App.toggle_window(windowName)}
    >
      <image iconName={"system-shutdown-symbolic"} />
    </BarButton>
  );
};
