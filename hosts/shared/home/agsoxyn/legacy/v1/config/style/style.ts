import { bash, dependencies, sh } from "lib/utils";
import { settings } from "settings";

const popoverPaddingMultiplier = 1.6;

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const $ = (name: string, value: string | number | boolean, unit?: string) =>
  `$${name}: ${value}${unit ? unit : ""};`;

const variables = () => [
  $("bg", `transparentize(${settings.theme.bg}, ${settings.theme.blur / 100})`),
  $("fg", settings.theme.fg),
  $("primary-bg", settings.theme.primary.bg),
  $("primary-fg", settings.theme.primary.fg),
  $("error-bg", settings.theme.error.bg),
  $("error-fg", settings.theme.error.fg),
  $("scheme", "dark"),
  $("padding", settings.theme.padding, "pt"),
  $("spacing", settings.theme.spacing, "pt"),
  $("radius", settings.theme.radius, "px"),
  $("transition", settings.transition, "ms"),
  $("shadows", settings.theme.shadows),
  $(
    "widget-bg",
    `transparentize(${settings.theme.widget.color}, ${
      settings.theme.widget.opacity / 100
    })`
  ),
  $(
    "hover-bg",
    `transparentize(${settings.theme.widget.color}, ${
      (settings.theme.widget.opacity * 0.9) / 100
    })`
  ),
  $("hover-fg", `lighten(${settings.theme.fg}, 8%)`),
  $("border-width", settings.theme.border.width, "px"),
  $(
    "border-color",
    `transparentize(${settings.theme.border.color}, ${
      settings.theme.border.opacity / 100
    })`
  ),
  $("border", "$border-width solid $border-color"),
  $(
    "active-gradient",
    `linear-gradient(to right, ${settings.theme.primary.bg}, darken(${settings.theme.primary.bg}, 4%))`
  ),
  $("shadow-color", "rgba(0, 0, 0, 0.6)"),
  $("text-shadow", "2pt 2pt 2pt $shadow-color"),
  $(
    "popover-border-color",
    `transparentize(${settings.theme.border.color}, ${Math.max(
      (settings.theme.border.opacity - 1) / 100,
      0
    )})`
  ),
  $("popover-padding", `$padding * ${popoverPaddingMultiplier}`),
  $("popover-radius", "$radius + $popover-padding"),
  $("font-size", settings.font.size, "pt"),
  $("font-name", settings.font.name),
  $("charging-bg", settings.bar.battery.charging),
  $("bar-battery-blocks", settings.bar.battery.blocks),
  $("bar-position", settings.bar.position),
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
