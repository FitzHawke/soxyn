import { subprocess } from "ags/process"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import AstalApps from "gi://AstalApps"
import Graphene from "gi://Graphene"
import { For, createState } from "ags"
import app from "ags/gtk4/app"

export const Launcher = () => {
  const uwsmLaunch = true
  const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor
  let contentbox: Gtk.Box
  let searchentry: Gtk.Entry
  let win: Astal.Window

  const apps = new AstalApps.Apps()
  const [list, setList] = createState(new Array<AstalApps.Application>())

  const launchCmd = (app: AstalApps.Application) => {
    const uwsm = (cmd: string) => {
      return subprocess({
        cmd: ["uwsm", "app", "--", cmd],
        err: (err) => console.error(err),
      })
    }

    win.hide()
    if (uwsmLaunch) {
      const exe = app.executable
        .split(/\s+/)
        .filter((str) => !str.startsWith("%") && !str.startsWith("@"))
        .join(" ")
      uwsm(exe)
      app.frequency += 1
    } else app.launch()
  }

  const AppItem = ({ app }: { app: AstalApps.Application }) => {
    const title = (
      <label
        cssClasses={["title"]}
        label={app.name}
        hexpand
        xalign={0}
        valign={Gtk.Align.CENTER}
      />
    )

    const description = (
      <label
        cssClasses={["description"]}
        label={app.description || ""}
        hexpand
        wrap
        maxWidthChars={30}
        xalign={0}
        justify={Gtk.Justification.LEFT}
        valign={Gtk.Align.CENTER}
      />
    )

    const appIcon = <image iconName={app.iconName} />

    const fullAppText = (
      <box
        orientation={Gtk.Orientation.VERTICAL}
        valign={Gtk.Align.CENTER}
        children={app.description ? [title, description] : [title]}
      />
    )

    return (
      <button
        cssClasses={["app-item"]}
        onClicked={() => {
          launchCmd(app)
        }}
      >
        <box>
          {appIcon}
          {fullAppText}
        </box>
      </button>
    )
  }

  function search(text: string) {
    if (text === "") setList([])
    else setList(apps.fuzzy_query(text).slice(0, 6))
  }

  // close on ESC
  // handle alt + number key
  function onKey(
    _e: Gtk.EventControllerKey,
    keyval: number,
    _: number,
    mod: number,
  ) {
    if (keyval === Gdk.KEY_Escape) {
      win.hide()
      return
    }

    if (keyval === Gdk.KEY_Return) {
      return launchCmd(list.get()[0])
    }

    if (mod === Gdk.ModifierType.ALT_MASK) {
      for (const i of [1, 2, 3, 4, 5, 6, 7, 8, 9] as const) {
        if (keyval === Gdk[`KEY_${i}`]) {
          return launchCmd(list.get()[i - 1])
        }
      }
    }
  }

  // close on clickaway
  function onClick(_e: Gtk.GestureClick, _: number, x: number, y: number) {
    const [, rect] = contentbox.compute_bounds(win)
    const position = new Graphene.Point({ x, y })

    if (!rect.contains_point(position)) {
      win.visible = false
      return true
    }
  }

  const txtEntry = (
    <entry
      $={(ref) => (searchentry = ref)}
      onNotifyText={({ text }) => search(text)}
    />
  )

  const placeHolder = (
    <box
      halign={Gtk.Align.CENTER}
      cssClasses={["not-found"]}
      orientation={Gtk.Orientation.VERTICAL}
      visible={list.as((l) => l.length === 0)}
    >
      <image iconName={"system-search-symbolic"} />
      <label label={"No Match Found"} />
    </box>
  )

  return (
    <window
      cssClasses={["launcher"]}
      $={(ref) => (win = ref)}
      name="launcher"
      application={app}
      anchor={TOP | BOTTOM | LEFT | RIGHT}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.EXCLUSIVE}
    >
      <box
        $={(ref) => (contentbox = ref)}
        name="launcher-content"
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        widthRequest={500}
        cssClasses={["app-launcher"]}
        orientation={Gtk.Orientation.VERTICAL}
      >
        {txtEntry}
        <box spacing={6} orientation={Gtk.Orientation.VERTICAL}>
          <For each={list}>{(app) => <AppItem app={app} />}</For>
        </box>
        {placeHolder}
      </box>
    </window>
  )
}
