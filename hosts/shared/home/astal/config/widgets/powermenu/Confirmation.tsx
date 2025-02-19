import { ModalWindow } from "@widgets/windows/ModalWindow";
import { currentCommand, currentLabel } from "./actions";
import { bind, exec } from "astal";
import { App } from "astal/gtk4";

export const Confirmation = () => {
  return (
    <ModalWindow name={"confirmation"} application={App}>
      <box vertical cssClasses={["confirmation"]}>
        <box cssClasses={["text-box"]} vertical>
          <label cssClasses={["title"]} label={bind(currentLabel)} />
          <label cssClasses={["desc"]} label={"Are you sure?"} />
        </box>
        <box cssClasses={["buttons", "horizontal"]} vexpand homogeneous>
          <button onClicked={() => App.toggle_window("confirmation")}>
            <label label={"No"} />
          </button>
          <button onClicked={() => exec(bind(currentCommand).get())}>
            <label label={"Yes"} />
          </button>
        </box>
      </box>
    </ModalWindow>
  );
};
