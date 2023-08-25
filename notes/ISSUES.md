# Known Issues

## Keeping track of broken/hacked things that need further attention to find the root of the problem or a proper solution

### dinraal

#### eww launches twice on system boot

- **Status** Still an issue 🤔
  - easy to fix by running `eww kill` once after boot
- doesn't happen on farosh
- possibly residue in config files from older builds

### farosh

#### bluetooth is inconsistent

- **Status** Solved, replace wifi/bluetooth hardware. Or just continue to never use bluetooth
- system does not even recognize having a bluetooth device
- wifi also likely has issues (primarily use wired connection)
  - on fedora it would randomly drop and reconnect
- ~~think it likely a firmware issue on motherboard~~
- definitely an issue with motherboard firmware
- to temporarily fix clear CMOS and then resetup bios
  - lesson of the day is realtek === 💩

### korok

see [here](../hosts/by-id/korok/README.md)

### common

#### electron apps

- ~~element-desktop crashes on launch unless launched on xwayland with `NIXOS_OZONE_WL= element-desktop`~~
- <https://github.com/NixOS/nixpkgs/issues/244486>
- currently overriding the electron version with a working one

- vscode _usually_ crashes on launch unless launched on xwayland with `NIXOS_OZONE_WL= code` -- This one really confuses me. Will crash approx 75% of the time with no rhyme or reason. Seemingly higher probability of working if attempted immediately after boot. Seems to change with various nixpkg updates

- webcord sometimes doesn't like video sharing. Seems to come and go with various nixpkg updates

#### steam

- intermittently crashes on launch. Seems to come and go with various nixpkg updates

#### eww

- tray
  - using custom build until tray is accepted into upstream
  - <https://github.com/elkowar/eww/pull/743>
  - spacing around apps in tray is tight
  - styling on dropdown menu is whack
- battery info still shows even on desktop without battery
- bluetooth still tries to show even when disabled
- brightness shows even on computers no adjustable brightness
- workspace tracking can be a little odd with multiple monitors (wrong color sometimes is most noticeable)

#### newsflash

- weird rendering if a line has multiple `$` present
- <https://gitlab.com/news-flash/news_flash_gtk/-/issues/397>

#### secrets

- will all be effectively written in plain text once quantum computing matures
- this means anything currently stored there should be considered public in the long term
- => we will need to do a full upgrade of both secrets AND their contents once new quantum resistant algorithms are stabilized and standardized
- also likely a good idea to do that with any private secrets (like our passwords in case the keepass db ever escaped)
