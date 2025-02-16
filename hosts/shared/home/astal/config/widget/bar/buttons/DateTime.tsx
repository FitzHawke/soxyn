import { Variable } from "astal";

const time = Variable("").poll(1000, "date");

export const DateTime = () => {
  return <label label={time()} />;
};
