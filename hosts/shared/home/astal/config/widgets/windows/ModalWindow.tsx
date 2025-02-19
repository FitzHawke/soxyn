import { Gtk } from "astal/gtk4";
import { Child, Padding, WindowFrame, WindowRevealer } from "./WindowFramework";
import { WindowProps } from "astal/gtk4/widget";

const Layout = (name: string, child: Child) => (
  <box
    children={[
      Padding(name),
      <box
        vertical={true}
        children={[
          Padding(name),
          WindowRevealer(name, child, Gtk.RevealerTransitionType.CROSSFADE),
          Padding(name),
        ]}
      />,
      Padding(name),
    ]}
  />
);

export const ModalWindow = ({ name, child, ...props }: WindowProps) =>
  WindowFrame({
    name,
    child: Layout(String(name), child),
    cssClasses: [String(name), "modal-window"],
    ...props,
  });
