export const theme = {
  notifications: {
    width: 440,
    blacklist: ["Spotify"],
    position: ["top", "right"],
  },

  osd: {
    microphone: {
      pack: {
        v: "end",
        h: "center",
      },
    },
    progress: {
      pack: {
        v: "center",
        h: "end",
      },
      vertical: true,
    },
  },

  datemenu: {
    position: "center",
  },

  quicksettings: {
    media: {
      coverSize: 100,
      monochromeIcon: true,
    },
    networkSettings: "gtk-launch gnome-control-center",
    position: "right",
    width: 380,
    avatar: {
      size: 70,
      image: "/var/lib/AccountsService/icons/will",
    },
  },

  powermenu: {
    labels: true,
    layout: "line",
    shutdown: "shutdown now",
    logout: "pkill Hyprland",
    reboot: "systemctl reboot",
    sleep: "systemctl suspend",
  },

  overview: {
    monochromeIcon: true,
    workspaces: 10,
    scale: 9,
  },

  launcher: {
    apps: {
      favorites: [
        [
          "firefox",
          "org.gnome.Nautilus",
          "org.gnome.Calendar",
          "obsidian",
          "discord",
          "spotify",
        ],
      ],
    },
    sh: {
      max: 6,
    },
    margin: 80,
    width: 0,
  },

  bar: {
    powermenu: {
      monochrome: true,
    },
    media: {
      length: 40,
      format: "{artists} - {title}",
      direction: "right",
      preferred: "spotify",
      monochrome: true,
    },
    systray: {
      ignore: ["KDE Connect Indicator", "spotify-client"],
    },
    taskbar: {
      exclusive: false,
      monochrome: true,
      iconSize: 0,
    },
    workspaces: {
      workspaces: 10,
    },
    battery: {
      low: 30,
      width: 50,
      blocks: 7,
      percentage: true,
      charging: "#00D787",
      bar: "regular",
    },
    date: {
      format: "%H:%M - %A %e.",
    },
    launcher: {
      label: {
        label: "Apps",
        colored: false,
      },
      icon: {
        icon: "nixos",
        colored: true,
      },
    },
    layout: {
      end: [
        "media",
        "expander",
        "systray",
        "colorpicker",
        "screenrecord",
        "system",
        "battery",
        "powermenu",
      ],
      center: ["date"],
      start: ["launcher", "workspaces", "taskbar", "expander", "messages"],
    },
    corner: true,
    position: "top",
    flatButtons: true,
  },

  font: {
    name: "Ubuntu Nerd Font",
    size: 10,
  },

  transition: 200,

  theme: {
    radius: 11,
    spacing: 12,
    padding: 7,
    shadows: true,
    border: {
      color: "#eeeeee",
      opacity: 96,
      width: 1,
    },
    widget: {
      color: "#eeeeee",
      opacity: 94,
    },
    scheme: "dark",
    blur: 50,
    fg: "#eeeeee",
    bg: "#171717",
    error: {
      fg: "#141414",
      bg: "#e55f86",
    },
    primary: {
      fg: "#141414",
      bg: "#51a4e7",
    },
  },

  autotheme: true,
};
