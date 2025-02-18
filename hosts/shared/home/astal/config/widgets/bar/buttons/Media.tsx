import { bind, timeout, Variable } from "astal";
import { Gtk } from "astal/gtk4";
import Mpris from "gi://AstalMpris";

export const Media = () => {
  const mpris = Mpris.get_default();
  const playctl = bind(mpris, "players").as((ps) => {
    const player = ps[0];
    if (!player) return <box />;

    const lbl = <label label={`${player.artist} - ${player.title}`} />;

    const ico = <image iconName={`${player.entry}-symbolic`} />;

    const reveal = Variable(false);

    const rev = (
      <revealer
        transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
        revealChild={bind(reveal)}
        // the setup doesnt work yet
        setup={(self) => {
          let current = "";
          bind(player, "title").as((p) => {
            if (current === p) return;

            current = p;
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
