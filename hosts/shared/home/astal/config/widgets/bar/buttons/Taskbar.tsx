import Hyprland from "gi://AstalHyprland";
import Apps from "gi://AstalApps";
import { BarButton } from "../BarButton";
import { Gtk, hook } from "astal/gtk4";
import { bind } from "astal";

export const Taskbar = () => {
  const hypr = Hyprland.get_default();
  const apps = new Apps.Apps();

  const setFocus = (address: string) =>
    hypr.dispatch("focuswindow", `address:0x${address}`);

  const DummyItem = (address: string) => <box name={address} visible={false} />;

  const AppItem = (address: string) => {
    const client = hypr.get_client(address);
    if (!client || client.class === "") return DummyItem(address);

    // Jank icon name detection. Maybe replace with a homemade map of {hyprland class -> icon name}
    const app = apps.list.find((app) => app.exact_match(client.class).name);

    const btn = (
      <BarButton
        tooltipText={bind(client, "title")}
        onClicked={() => setFocus(address)}
      >
        <image iconName={app?.iconName} />
      </BarButton>
    );

    return (
      <box name={address} visible>
        <overlay>
          <box
            type="overlay"
            cssClasses={["indicator"]}
            halign={Gtk.Align.CENTER}
            valign={Gtk.Align.START}
            setup={(self) => {
              hook(self, hypr, "event", (_, event, arg) => {
                if (event === "activewindowv2") {
                  arg === address
                    ? self.add_css_class("active")
                    : self.remove_css_class("active");
                }
              });
            }}
          />
          {btn}
        </overlay>
      </box>
    );
  };

  const sortItems = (arr: Gtk.Widget[]) => {
    return arr.sort((a, b) => {
      const aClient = hypr.get_client(a.name)!;
      const bClient = hypr.get_client(b.name)!;
      return aClient.workspace.id - bClient.workspace.id;
    });
  };

  return (
    <box
      cssClasses={["taskbar"]}
      setup={(self) => {
        hook(self, hypr, "client-removed", (_, addy) => {
          self.children = self.children.filter(
            (ch) => (ch.name || "") !== addy,
          );
        });
        hook(self, hypr, "client-added", (_, client) => {
          self.children = sortItems([
            ...self.children,
            AppItem(client.address),
          ]);
        });
        hook(self, hypr, "event", (_, event, args, ex) => {
          if (event === "movewindow") self.children = sortItems(self.children);
        });
      }}
    >
      {sortItems(hypr.clients.map((c) => AppItem(c.address)))}
    </box>
  );
};
