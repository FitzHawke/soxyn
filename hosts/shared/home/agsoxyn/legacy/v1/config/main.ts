import "lib/session";
import "style/style";
import init from "lib/init";
import Bar from "widget/bar/Bar";
import Launcher from "widget/launcher/Launcher";
import NotificationPopups from "widget/notifications/NotificationPopups";
import OSD from "widget/osd/OSD";
import Overview from "widget/overview/Overview";
import PowerMenu from "widget/powermenu/PowerMenu";
import ScreenCorners from "widget/bar/ScreenCorners";
import SettingsDialog from "widget/settings/SettingsDialog";
import Verification from "widget/powermenu/Verification";
import { forMonitors } from "lib/utils";
import { setupQuickSettings } from "widget/quicksettings/QuickSettings";
import { setupDateMenu } from "widget/datemenu/DateMenu";
import { settings } from "settings";

App.config({
  onConfigParsed: () => {
    setupQuickSettings();
    setupDateMenu();
    init();
  },
  closeWindowDelay: {
    launcher: settings.transition,
    overview: settings.transition,
    quicksettings: settings.transition,
    datemenu: settings.transition,
  },
  windows: () => [
    ...forMonitors(Bar),
    ...forMonitors(NotificationPopups),
    ...forMonitors(ScreenCorners),
    ...forMonitors(OSD),
    Launcher(),
    Overview(),
    PowerMenu(),
    SettingsDialog(),
    Verification(),
  ],
});
