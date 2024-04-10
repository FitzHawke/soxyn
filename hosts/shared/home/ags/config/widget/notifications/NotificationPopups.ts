import Notification from "./Notification";
import { settings } from "settings";

const notifications = await Service.import("notifications");
const { transition } = settings;
const { position } = settings.notifications;
const { timeout, idle } = Utils;

function Animated(id: number) {
  const n = notifications.getNotification(id)!;
  const widget = Notification(n);

  const inner = Widget.Revealer({
    transition: "slide_left",
    transition_duration: transition,
    child: widget,
  });

  const outer = Widget.Revealer({
    transition: "slide_down",
    transition_duration: transition,
    child: inner,
  });

  const box = Widget.Box({
    hpack: "end",
    child: outer,
  });

  idle(() => {
    outer.reveal_child = true;
    timeout(transition, () => {
      inner.reveal_child = true;
    });
  });

  return Object.assign(box, {
    dismiss() {
      inner.reveal_child = false;
      timeout(transition, () => {
        outer.reveal_child = false;
        timeout(transition, () => {
          box.destroy();
        });
      });
    },
  });
}

function PopupList() {
  const map: Map<number, ReturnType<typeof Animated>> = new Map();
  const box = Widget.Box({
    hpack: "end",
    vertical: true,
    css: `min-width: ${settings.notifications.width}px;`,
  });

  function remove(_: unknown, id: number) {
    map.get(id)?.dismiss();
    map.delete(id);
  }

  return box
    .hook(
      notifications,
      (_, id: number) => {
        if (id !== undefined) {
          if (map.has(id)) remove(null, id);

          if (notifications.dnd) return;

          const w = Animated(id);
          map.set(id, w);
          box.children = [w, ...box.children];
        }
      },
      "notified"
    )
    .hook(notifications, remove, "dismissed")
    .hook(notifications, remove, "closed");
}

export default (monitor: number) =>
  Widget.Window({
    monitor,
    name: `notifications${monitor}`,
    anchor: position,
    class_name: "notifications",
    child: Widget.Box({
      css: "padding: 2px;",
      child: PopupList(),
    }),
  });
