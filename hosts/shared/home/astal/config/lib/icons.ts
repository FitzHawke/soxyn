import { Gio } from "astal";

type IconMapType = { [key: string]: string };

const fallback = "application-x-executable-symbolic";

const iconMap: IconMapType = {
  // browser
  firefox: "firefox-symbolic",
  "chromium-browser": "chromium-browser-symbolic",

  // text editor
  "dev.zed.Zed": "cus-zed-symbolic",
  "org.gnome.TextEditor": "org.gnome.TextEditor-symbolic",
  code: "org.gnome.TextEditor-symbolic",

  // socials
  discord: "cus-discord-symbolic",
  legcord: "cus-discord-symbolic",
  Element: "cus-element-symbolic",
  "so.libdb.dissent": "so.libdb.dissent-symbolic",

  // gaming
  steam: "cus-steam-symbolic",
  "net.lutris.Lutris": "applications-games-symbolic",
  "onion.torzu_emu.torzu": "applications-games-symbolic",
  Ryujinx: "applications-games-symbolic",

  // media
  "io.github.quodlibet.QuodLibet": "io.github.quodlibet.QuodLibet-symbolic",
  "io.github.quodlibet.ExFalso": "io.github.quodlibet.ExFalso-symbolic",
  "org.gnome.Loupe": "org.gnome.Loupe-symbolic",
  "io.bassi.amberol": "io.bassi.Amberol-symbolic",
  "io.github.celluloid_player.Celluloid":
    "io.github.celluloid_player.Celluloid-symbolic",
  spotify: "applications-games-symbolic",
  "Gimp-2.10": "applications-graphics-symbolic",

  // office
  "libreoffice-imprerss": "libreoffice-impress-symbolic",
  "libreoffice-calc": "libreoffice-calc-symbolic",
  "libreoffice-base": "libreoffice-base-symbolic",
  "libreoffice-math": "libreoffice-math-symbolic",
  "libreoffice-writer": "libreoffice-writer-symbolic",
  "libreoffice-draw": "libreoffice-draw-symbolic",
  "libreoffice-startcenter": "libreoffice-main-symbolic",
  "org.gnome.Evolution": "evolution-symbolic",
  "org.gnome.Calculator": "org.gnome.Calculator-symbolic",
  "org.gnome.Calendar": "org.gnome.Calendar-symbolic",
  "com.github.johnfactotum.Foliate": "com.github.johnfactotum.Foliate-symbolic",
  "io.gitlab.news_flash.NewsFlash": "io.gitlab.news_flash.NewsFlash-symbolic",
  anki: "semi-starred-symbolic",

  // utilities
  foot: "utilities-terminal-symbolic",
  "org.gnome.Nautilus": "org.gnome.Nautilus-symbolic",
  "gnome-disks": "org.gnome.DiskUtility-symbolic",
  "org.pulseaudio.pavucontrol": "multimedia-volume-control-symbolic",
  "org.gnome.FileRoller": "org.gnome.FileRoller-symbolic",
  "org.gnome.Settings": "org.gnome.Settings-symbolic",
  Bitwarden: "lock-symbolic",
};

export const getClientIcon = (name: string): Gio.Icon => {
  return Gio.Icon.new_for_string(iconMap[name] || fallback);
};
