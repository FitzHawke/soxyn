import { Variable } from "astal";

const time = Variable("").poll(1000, 'date +"%H:%M - %a %d"');

export const DateTime = () => {
  return <label label={time()} />;
};
