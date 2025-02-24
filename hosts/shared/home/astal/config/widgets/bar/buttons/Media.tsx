import { bind, timeout, Variable } from "astal";
import { Gtk, hook } from "astal/gtk4";
import Mpris from "gi://AstalMpris";
import { BarButton } from "../BarButton";

export const Media = () => {
  const mpris = Mpris.get_default();

  const players = bind(mpris, "players");
  const playerNum = Variable(0);

  const nextPlayer = () => {
    playerNum.set((playerNum.get() + 1) % players.get().length);
  };
  const curPlayer = Variable.derive(
    [players, playerNum],
    (players: Mpris.Player[], num: number) => players[num],
  );

  const reveal = Variable(false);

  const lbl = (p: Mpris.Player) => (
    <label label={bind(p, "metadata").as(() => `${p.artist} - ${p.title}`)} />
  );

  const ico = (p: Mpris.Player) => <image iconName={`${p.entry}-symbolic`} />;

  const rev = (p: Mpris.Player) => (
    <revealer
      transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
      revealChild={bind(reveal)}
      setup={(self) => {
        let current = "";
        hook(self, p, "notify::title", () => {
          if (current === p.title) return;

          current = p.title;
          reveal.set(true);
          timeout(3000, () => reveal.set(false));
        });
      }}
    >
      {lbl(p)}
    </revealer>
  );

  return (
    <BarButton
      cssClasses={["media"]}
      onButtonReleased={(_, ev) => {
        ev.get_button() === 2 ? nextPlayer() : curPlayer.get().play_pause();
      }}
      onScroll={(_, _dx, dy) => {
        if (dy > 0) curPlayer.get().next();
        else if (dy < 0) curPlayer.get().previous();
      }}
      onHoverEnter={() => reveal.set(true)}
      onHoverLeave={() => reveal.set(false)}
      onDestroy={() => curPlayer.drop()}
      visible={bind(players).as((p) => p.length > 0)}
    >
      {bind(curPlayer).as((cur) => {
        if (!cur) return <box />;
        return (
          <box>
            {ico(cur)}
            {rev(cur)}
          </box>
        );
      })}
    </BarButton>
  );
};
