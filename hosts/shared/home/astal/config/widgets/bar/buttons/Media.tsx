import { bind, timeout, Variable } from "astal";
import { Gtk, hook } from "astal/gtk4";
import Mpris from "gi://AstalMpris";

export const Media = () => {
  const mpris = Mpris.get_default();
  const playctl = bind(mpris, "players").as((ps) => {
    const player = ps[0];
    if (!player) return <box />;

    const lbl = (
      <label
        label={bind(player, "metadata").as(
          () => `${player.artist} - ${player.title}`,
        )}
      />
    );

    const ico = <image iconName={`${player.entry}-symbolic`} />;

    const reveal = Variable(false);

    const rev = (
      <revealer
        transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
        revealChild={bind(reveal)}
        setup={(self) => {
          let current = "";
          hook(self, player, "notify", () => {
            if (current === player.title) return;

            current = player.title;
            reveal.set(true);
            timeout(3000, () => reveal.set(false));
          });
        }}
      >
        {lbl}
      </revealer>
    );

    return (
      <button
        onClicked={() => player.play_pause()}
        onScroll={(_, _dx, dy) => {
          if (dy > 0) player.next();
          else if (dy < 0) player.previous();
        }}
        onHoverEnter={() => reveal.set(true)}
        onHoverLeave={() => reveal.set(false)}
      >
        <box>
          {ico}
          {rev}
        </box>
      </button>
    );
  });

  return <box cssClasses={["media", "panel-button"]}>{playctl}</box>;
};
