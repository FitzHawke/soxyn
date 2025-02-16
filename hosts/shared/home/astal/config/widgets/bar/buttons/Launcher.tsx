import { App } from "astal/gtk4";
import { BarButton } from "../BarButton";

export const Launcher = () => {
  const windowName = "launcher";
  return BarButton({
    window: windowName,
    onClicked: () => App.toggle_window(windowName),
    child: <label label={"Apps"} />,
  });
};
