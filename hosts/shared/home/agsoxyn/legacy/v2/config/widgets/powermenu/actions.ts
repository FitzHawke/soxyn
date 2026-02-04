import { Variable } from "astal";
import { App } from "astal/gtk4";

export type Action = "sleep" | "reboot" | "logout" | "shutdown";

export type Act = {
  label: string;
  iconName: string;
  command: string;
};

type Actions = {
  sleep: Act;
  reboot: Act;
  logout: Act;
  shutdown: Act;
};

export const actions: Actions = {
  sleep: {
    label: "Sleep",
    iconName: "system-suspend-symbolic",
    command: "loginctl lock-session && systemd suspend",
  },
  reboot: {
    label: "Reboot",
    iconName: "system-restart-symbolic",
    command: "systemctl reboot",
  },
  logout: {
    label: "Log Out",
    iconName: "system-log-out-symbolic",
    command: "loginctl terminate-session $XDG_SESSION_ID",
  },
  shutdown: {
    label: "Shutdown",
    iconName: "system-shutdown-symbolic",
    command: "systemctl poweroff",
  },
};

export const currentLabel = Variable("");
export const currentCommand = Variable("");

export const confirmAction = (action: Act) => {
  currentLabel.set(action.label);
  currentCommand.set(action.command);
  App.toggle_window("powermenu");
  App.toggle_window("confirmation");
};
