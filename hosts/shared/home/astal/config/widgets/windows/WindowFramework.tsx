import { App, Astal, Gdk, Gtk, hook } from "astal/gtk4";
import { BoxProps, RevealerProps, WindowProps } from "astal/gtk4/widget";

type PaddingProps = BoxProps & {
  winName: string;
};

// Window Location Code
// -1 | 0 | 1
// top | mid | bottom
// left | mid | right
type WinLocCode = -1 | 0 | 1;

type LayoutProps = BoxProps & {
  winName: string;
  marginRequest: number;
  hLoc: WinLocCode;
  vLoc: WinLocCode;
};

type FrameProps = WindowProps & {
  marginRequest?: number;
  hLoc?: WinLocCode;
  vLoc?: WinLocCode;
  transition?: RevealerProps["transitionType"];
};

const Padding = ({
  winName,
  cssClasses = [""],
  hexpand = true,
  vexpand = true,
  ...props
}: PaddingProps) => (
  <box
    hexpand={hexpand}
    vexpand={vexpand}
    canFocus={false}
    canTarget={true}
    cssClasses={cssClasses}
    onButtonReleased={() => App.toggle_window(winName)}
    {...props}
  />
);

const WindowRevealer = ({
  name,
  child,
  transitionType,
  ...props
}: RevealerProps) => (
  <box
    cssClasses={["pad1"]}
    child={
      <revealer
        transitionType={transitionType}
        child={<box cssClasses={["window-content"]} child={child} />}
        transitionDuration={200}
        setup={(self) =>
          hook(self, App, "window-toggled", (_, wname) => {
            self.revealChild = wname.name === name;
          })
        }
        {...props}
      />
    }
  />
);

const WindowLayout = ({
  winName,
  child,
  marginRequest,
  hLoc,
  vLoc,
}: LayoutProps) => (
  <box>
    <Padding
      winName={winName}
      hexpand={hLoc !== -1}
      widthRequest={hLoc === -1 ? marginRequest : 0}
    />
    <box vertical={true} halign={hLoc === 0 ? Gtk.Align.CENTER : undefined}>
      <Padding
        winName={winName}
        vexpand={vLoc !== -1}
        heightRequest={vLoc === -1 ? marginRequest : 0}
      />
      {child}
      <Padding
        winName={winName}
        vexpand={vLoc !== 1}
        heightRequest={vLoc === 1 ? marginRequest : 0}
      />
    </box>
    <Padding
      winName={winName}
      hexpand={hLoc !== 1}
      widthRequest={hLoc === 1 ? marginRequest : 0}
    />
    ,
  </box>
);

export const WindowFrame = ({
  name,
  child,
  exclusivity = Astal.Exclusivity.IGNORE,
  marginRequest = 0,
  hLoc = 0,
  vLoc = 0,
  transition = Gtk.RevealerTransitionType.CROSSFADE,
  ...props
}: FrameProps) => {
  const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      name={name}
      onKeyPressed={(_, keyval) => {
        if (keyval === Gdk.KEY_Escape) App.get_window(String(name))?.hide();
      }}
      visible={false}
      exclusivity={exclusivity}
      keymode={Astal.Keymode.ON_DEMAND}
      layer={Astal.Layer.TOP}
      anchor={TOP | BOTTOM | LEFT | RIGHT}
      {...props}
    >
      <WindowLayout
        winName={String(name)}
        marginRequest={marginRequest}
        vLoc={vLoc}
        hLoc={hLoc}
      >
        <WindowRevealer
          name={name}
          transitionType={transition}
          valign={vLoc === 0 ? Gtk.Align.CENTER : undefined}
        >
          {child}
        </WindowRevealer>
      </WindowLayout>
    </window>
  );
};
