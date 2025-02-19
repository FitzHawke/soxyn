import { Gtk } from "astal/gtk4";
import { Child, Padding, WindowFrame, WindowRevealer } from "./WindowFramework";
import { WindowProps } from "astal/gtk4/widget";

type DropProps = WindowProps & {
  marginRequest: number;
};

const Layout = (name: string, child: Child, marginRequest: number) => (
  <box
    children={[
      Padding(name),
      <box
        vertical={true}
        children={[
          Padding(name, { vexpand: false, heightRequest: marginRequest }),
          WindowRevealer(name, child, Gtk.RevealerTransitionType.SLIDE_DOWN),
          Padding(name),
        ]}
      />,
      Padding(name),
    ]}
  />
);

export const DropWindow = ({
  name,
  child,
  marginRequest = 0,
  ...props
}: DropProps) => (
  <WindowFrame
    name={name}
    cssClasses={[String(name), "drop-window"]}
    {...props}
  >
    {Layout(String(name), child, marginRequest)}
  </WindowFrame>
);
