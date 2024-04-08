import { bash, dependencies, sh } from "lib/utils";
import { theme } from "settings/theme";

const popoverPaddingMultiplier = 1.6;

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const $ = (name: string, value: string | number | boolean, unit?: string) =>
  `$${name}: ${value}${unit ? unit : ""};`;

const variables = () => [
  $("bg", `transparentize(${theme.theme.bg}, ${theme.theme.blur / 100})`),
  $("fg", theme.theme.fg),
  $("primary-bg", theme.theme.primary.bg),
  $("primary-fg", theme.theme.primary.fg),
  $("error-bg", theme.theme.error.bg),
  $("error-fg", theme.theme.error.fg),
  $("scheme", "dark"),
  $("padding", theme.theme.padding, "pt"),
  $("spacing", theme.theme.spacing, "pt"),
  $("radius", theme.theme.radius, "px"),
  $("transition", theme.transition, "ms"),
  $("shadows", theme.theme.shadows),
  $(
    "widget-bg",
    `transparentize(${theme.theme.widget.color}, ${
      theme.theme.widget.opacity / 100
    })`
  ),
  $(
    "hover-bg",
    `transparentize(${theme.theme.widget.color}, ${
      (theme.theme.widget.opacity * 0.9) / 100
    })`
  ),
  $("hover-fg", `lighten(${theme.theme.fg}, 8%)`),
  $("border-width", theme.theme.border.width, "px"),
  $(
    "border-color",
    `transparentize(${theme.theme.border.color}, ${
      theme.theme.border.opacity / 100
    })`
  ),
  $("border", "$border-width solid $border-color"),
  $(
    "active-gradient",
    `linear-gradient(to right, ${theme.theme.primary.bg}, darken(${theme.theme.primary.bg}, 4%))`
  ),
  $("shadow-color", "rgba(0, 0, 0, 0.6)"),
  $("text-shadow", "2pt 2pt 2pt $shadow-color"),
  $(
    "popover-border-color",
    `transparentize(${theme.theme.border.color}, ${Math.max(
      (theme.theme.border.opacity - 1) / 100,
      0
    )})`
  ),
  $("popover-padding", `$padding * ${popoverPaddingMultiplier}`),
  $("popover-radius", "$radius + $popover-padding"),
  $("font-size", theme.font.size, "pt"),
  $("font-name", theme.font.name),
  $("charging-bg", theme.bar.battery.charging),
  $("bar-battery-blocks", theme.bar.battery.blocks),
  $("bar-position", theme.bar.position),
];

async function setCss() {
  if (!dependencies("sass", "fd")) return;

  try {
    const fd = await sh(`fd ".scss" ${App.configDir}`);
    const files = fd.split(/\s+/).map((f) => `@import "${f}";`);
    const scss = [...variables(), ...files].join("\n");
    const css = await bash`echo '${scss}' | sass --stdin`;

    App.applyCss(css, true);
  } catch (error) {
    logError(error);
  }
}

await setCss();
