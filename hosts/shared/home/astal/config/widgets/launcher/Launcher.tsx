import { DropWindow } from "@widgets/windows/DropWindow";
import { subprocess, Variable } from "astal";
import { App, Gtk, hook } from "astal/gtk4";
import Apps from "gi://AstalApps";

export const Launcher = () => {
  const uwsmLaunch = false;
  const apps = new Apps.Apps();
  const searchTxt = Variable("");

  const hide = () => App.get_window("launcher")?.hide();

  const launchCmd = (app: Apps.Application) => {
    const uwsm = (cmd: string) => {
      return subprocess({
        cmd: ["uwsm", "app", "--", cmd],
        err: (err) => console.error(err),
      });
    };

    if (uwsmLaunch) {
      const exe = app.executable
        .split(/\s+/)
        .filter((str) => !str.startsWith("%") && !str.startsWith("@"))
        .join(" ");
      uwsm(exe);
      app.frequency += 1;
    } else app.launch();
  };

  const AppItem = ({ app }: { app: Apps.Application }) => {
    const title = (
      <label
        cssClasses={["title"]}
        label={app.name}
        hexpand
        xalign={0}
        valign={Gtk.Align.CENTER}
      />
    );

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
    );

    const appIcon = <image iconName={app.iconName} />;

    const fullAppText = (
      <box
        vertical
        valign={Gtk.Align.CENTER}
        children={app.description ? [title, description] : [title]}
      />
    );

    return (
      <button
        cssClasses={["app-item"]}
        onClicked={() => {
          launchCmd(app);
          hide();
        }}
      >
        <box>
          {appIcon}
          {fullAppText}
        </box>
      </button>
    );
  };

  const list = searchTxt((txt) => apps.fuzzy_query(txt).slice(0, 6));
  const onEnter = () => {
    launchCmd(list.get()[0]);
    hide();
  };

  const txtEntry = (
    <entry
      placeholderText={"Search..."}
      onNotifyText={(self) => searchTxt.set(self.text)}
      onActivate={onEnter}
      setup={(self) =>
        hook(self, App, "window-toggled", (_, win) => {
          if (win.name === "launcher") self.text = "";
        })
      }
    />
  );

  const placeHolder = (
    <box
      halign={Gtk.Align.CENTER}
      cssClasses={["not-found"]}
      vertical
      visible={list.as((l) => l.length === 0)}
    >
      <image iconName={"system-search-symbolic"} />
      <label label={"No Match Found"} />
    </box>
  );

  return (
    <DropWindow name={"launcher"} application={App} marginRequest={80}>
      <box widthRequest={500} cssClasses={["app-launcher"]} vertical>
        {txtEntry}
        <box spacing={6} vertical>
          {list.as((l) => l.map((app) => <AppItem app={app} />))}
        </box>
        {placeHolder}
      </box>
    </DropWindow>
  );
};
