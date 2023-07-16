# Known Issues

## Keeping track of broken/hacked things that need further attention to find the root of the problem or a proper solution

### dinraal

- eww launches twice on system boot
  - **Status** Minor
    - easy to fix by running `eww kill` once after boot
  - doesn't happen on farosh
  - possibly residue in config files from older builds

### farosh

- bluetooth is inconsistent
  - **Status** Minor
    - only use bluetooth for controller connection, can use usb instead
  - was also a problem on fedora
  - no observed rhyme or reason to whether it works
  - system does not even recognise having a bluetooth device
  - goes for a long period (days/weeks) before randomly 'toggling' its status
  - wifi also likely has issues (primarily use wired connection)
    - on fedora it would randomly drop and reconnect
  - think it likely a firmware issue on motherboard
    - possibly loading an incorrect driver?

### common

#### electron apps

- element-desktop crashes on launch unless launched with `NIXOS_OZONE_WL= %command`
- vscode *usually* crashes on launch unless launched with `NIXOS_OZONE_WL= %command` -- This one really confuses me. Will crash approx 95% of the time with no rhyme or reason. Seemingly higher probablility of working if attempted immediately after boot.

#### steam

- ~~crashes on launch~~ seems like a nixpkgs update fixed this. Keep an eye and see if being broken is common.

#### eww

- using custom build until tray is accepted into upstream
- spacing around apps in tray is tight
- styling on dropdown menu is whack
- clicks dont always register on tray dropdown
- battery ring still shows even on desktop without battery
- bluetooth still tries to show even when disabled
- brightness shows even on computers without adjustable brightness
- workspace tracking can be a little odd with multiple monitors (wrong color sometimes is most noticeable)
