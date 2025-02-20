import { Variable } from "astal";
import { BarButton } from "../BarButton";
import { App } from "astal/gtk4";

const time = Variable("").poll(1000, 'date +"%H:%M - %a %d"');

export const DateTime = () => {
  const windowName = "datemenu";
  return (
    <BarButton
      window={windowName}
      onClicked={() => App.toggle_window(windowName)}
    >
      <label label={time()} />
    </BarButton>
  );
};
