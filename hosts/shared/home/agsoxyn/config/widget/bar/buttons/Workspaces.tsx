import Hyprland from "gi://AstalHyprland"
import app from "ags/gtk4/app"
import Gtk from "gi://Gtk?version=4.0"
import { createBinding, onCleanup } from "ags"

export const Workspaces = () => {
  const hypr = Hyprland.get_default()

  const onScroll = (_: Gtk.EventControllerScroll, _dx: number, dy: number) => {
    if (dy > 0) hypr.dispatch("workspace", "m+1")
    else if (dy < 0) hypr.dispatch("workspace", "m-1")
  }

  const nums = [...Array(10).keys()].map((c) => c + 1)

  const Workspace = () => (
    <box>
      {nums.map((num) => (
        <label
          label={String(num)}
          valign={Gtk.Align.CENTER}
          $={(self) => {
            const sub = hypr.connect("event", () => {
              hypr.focused_workspace.id === num
                ? self.add_css_class("active")
                : self.remove_css_class("active")
              ;(hypr.get_workspace(num)?.clients.length || 0) > 0
                ? self.add_css_class("occupied")
                : self.remove_css_class("occupied")
            })
          }}
        />
      ))}
    </box>
  )

  const windowName = "overview"

  return (
    <button
      cssClasses={["workspaces"]}
      onClicked={() => app.toggle_window(windowName)}
    >
      <Gtk.EventControllerScroll
        onScroll={onScroll}
        propagationPhase={Gtk.PropagationPhase.CAPTURE}
        flags={Gtk.EventControllerScrollFlags.BOTH_AXES}
      />
      <Workspace />
    </button>
  )
}
