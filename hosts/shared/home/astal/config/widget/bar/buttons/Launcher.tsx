import { App } from "astal/gtk4";

export const Launcher = () => {
  return (
    <box>
      <button onClicked={() => App.get_window("launcher")!.show()}>
        <label label={" launch "} />
      </button>
    </box>
  );
};
