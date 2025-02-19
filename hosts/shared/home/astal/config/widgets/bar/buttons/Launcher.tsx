import { App } from "astal/gtk4";
import { BarButton } from "../BarButton";

export const Launcher = () => {
  const windowName = "launcher";
  return (
    <BarButton
      window={windowName}
      onClicked={() => App.toggle_window(windowName)}
    >
      <box>
        <image iconName={"view-app-grid-symbolic"} />
        <label label={"Apps"} />
      </box>
    </BarButton>
  );
};
