import { App, Astal, Gdk, hook } from "astal/gtk4";
import { BoxProps, RevealerProps, WindowProps } from "astal/gtk4/widget";

export type Child = WindowProps["child"];
type Transition = RevealerProps["transitionType"];
type WindowRevealerProps = RevealerProps & {};

export const Padding = (
  name: string,
  {
    cssClasses = [""],
    hexpand = true,
    vexpand = true,
    ...props
  }: BoxProps = {},
) => (
  <box
    hexpand={hexpand}
    vexpand={vexpand}
    canFocus={false}
    canTarget={true}
    child={<box cssClasses={cssClasses} />}
    onButtonReleased={() => App.toggle_window(name)}
    {...props}
  />
);

export const WindowRevealer = ({
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

const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;

export const WindowFrame = ({
  name,
  child,
  exclusivity = Astal.Exclusivity.IGNORE,
  cssClasses,
  ...props
}: WindowProps) => (
  <window
    name={name}
    cssClasses={cssClasses}
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
    {child}
  </window>
);
