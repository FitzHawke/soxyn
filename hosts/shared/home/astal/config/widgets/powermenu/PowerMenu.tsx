import { ModalWindow } from "@widgets/windows/ModalWindow";
import { Act, confirmAction, actions } from "./actions";
import { App } from "astal/gtk4";

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
    <ModalWindow name={"powermenu"} application={App}>
      <box cssClasses={["line", "powermenu", "horizontal"]}>
        {Object.entries(actions).map((a) => (
          <SysButton action={a[1]} />
        ))}
      </box>
    </ModalWindow>
  );
};
