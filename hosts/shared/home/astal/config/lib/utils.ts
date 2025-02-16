export const range = (length: number, start: number = 1) => {
  return Array.from({ length }, (_, i) => i + start);
};
