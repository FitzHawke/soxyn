import { Act, confirmAction, actions } from "./actions";
import { App } from "astal/gtk4";
import { WindowFrame } from "@widgets/windows/WindowFramework";

export const PowerMenu = () => {
  const SysButton = ({ action }: { action: Act }) => (
    <button onClicked={() => confirmAction(action)}>
      <box vertical cssClasses={["system-button"]}>
        <image iconName={action.iconName} />
        <label label={action.label} />
      </box>
    </button>
  );

  return (
    <WindowFrame
      name={"powermenu"}
      application={App}
      cssClasses={["powermenu"]}
    >
      <box cssClasses={["powermenu"]}>
        {Object.entries(actions).map((a) => (
          <SysButton action={a[1]} />
        ))}
      </box>
    </WindowFrame>
  );
};
