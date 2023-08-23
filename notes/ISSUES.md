# Known Issues

## Keeping track of broken/hacked things that need further attention to find the root of the problem or a proper solution

### dinraal

- eww launches twice on system boot
  - **Status** Still an issue 🤔
    - easy to fix by running `eww kill` once after boot
  - doesn't happen on farosh
  - possibly residue in config files from older builds

### farosh

- bluetooth is inconsistent
  - **Status** Minor
    - only use bluetooth for controller connection, can use usb instead
  - was also a problem on fedora
  - no observed rhyme or reason to whether it works
  - system does not even recognize having a bluetooth device
  - goes for a long period (days/weeks) before randomly 'toggling' its status
  - wifi also likely has issues (primarily use wired connection)
    - on fedora it would randomly drop and reconnect
  - ~~think it likely a firmware issue on motherboard~~
    - definitely an issue with motherboard firmware
    - to temporarily fix clear CMOS and then resetup bios
      - lesson of the day is realtek === 💩

### common

#### electron apps

- ~~element-desktop crashes on launch unless launched on xwayland with `NIXOS_OZONE_WL= element-desktop`~~
- <https://github.com/NixOS/nixpkgs/issues/244486>

- vscode *usually* crashes on launch unless launched on xwayland with `NIXOS_OZONE_WL= code` -- This one really confuses me. Will crash approx 95% of the time with no rhyme or reason. Seemingly higher probability of working if attempted immediately after boot.

#### steam

- crashes on launch. seems like a nixpkgs update fixed this. Keep an eye and see if being broken is common.

#### eww

- tray
  - using custom build until tray is accepted into upstream
    - <https://github.com/elkowar/eww/pull/743>
  - spacing around apps in tray is tight
  - styling on dropdown menu is whack
  - clicks don't always register on tray dropdown
- battery ring still shows even on desktop without battery
- bluetooth still tries to show even when disabled
- brightness shows even on computers without adjustable brightness
- workspace tracking can be a little odd with multiple monitors (wrong color sometimes is most noticeable)

#### newsflash

- weird rendering if a line has multiple `$` present
- <https://gitlab.com/news-flash/news_flash_gtk/-/issues/397>
