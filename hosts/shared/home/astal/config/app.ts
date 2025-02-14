import { App } from "astal/gtk4";
import style from "./style/style.scss";
import Bar from "./widget/Bar";

App.start({
  css: style,
  main() {
    App.get_monitors().map(Bar);
  },
});
