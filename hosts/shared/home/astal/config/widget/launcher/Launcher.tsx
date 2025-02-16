import { Variable } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import Apps from "gi://AstalApps";

const fancyLaunch = false;

const hide = () => App.get_window("launcher")!.hide();
const launchCmd = (app: Apps.Application) => {
  if (fancyLaunch) {
    // uwsm app -- app.exec (?)
    // https://github.com/Aylur/astal/issues/259
    // may need to do special parsing or env shennanigans
  } else app.launch();
};

const SingleApp = ({ app }: { app: Apps.Application }) => {
  return (
    <button
      cssClasses={["AppButton"]}
      onClicked={() => {
        hide();
        launchCmd(app);
      }}
    >
      <box>
        <image iconName={app.iconName} />
        <label
          cssClasses={["app-name"]}
          valign={Gtk.Align.CENTER}
          xalign={0}
          label={app.name}
        />
      </box>
    </button>
  );
};

export const Launcher = () => {
  const MAX_ITEMS = 5;
  const apps = new Apps.Apps();
  const width = Variable(1000);

  const text = Variable("");
  const list = text((text) => apps.fuzzy_query(text).slice(0, MAX_ITEMS));
  const onEnter = () => {
    launchCmd(apps.fuzzy_query(text.get())?.[0]);
    hide();
  };
  return (
    <window
      name="launcher"
      anchor={Astal.WindowAnchor.TOP}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.ON_DEMAND}
      application={App}
      onKeyPressed={(_, keyval) => {
        if (keyval === Gdk.KEY_Escape) hide();
      }}
    >
      <box>
        <button onClicked={hide} hexpand widthRequest={width((w) => w / 2)} />
        <box hexpand={false} vertical>
          <button heightRequest={100} onClicked={hide} />
          <box widthRequest={500} cssClasses={["AppLauncher"]} vertical>
            <entry
              placeholderText="Search..."
              onNotifyText={(self) => text.set(self.text)}
              onActivate={onEnter}
            />
            <box spacing={6} vertical>
              {list.as((list) => list.map((app) => <SingleApp app={app} />))}
            </box>
            <box
              halign={Gtk.Align.CENTER}
              cssClasses={["not-found"]}
              vertical
              visible={list.as((l) => l.length === 0)}
            >
              <image iconName="system-search-symbolic" />
              <label label="No Match Found" />
            </box>
          </box>
          <button vexpand onClicked={hide} />
        </box>
        <button widthRequest={width((w) => w / 2)} hexpand onClicked={hide} />
      </box>
    </window>
  );
};
