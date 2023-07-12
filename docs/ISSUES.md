# Known Issues

## Keeping track of broken/hacked things that need further attention to find the root of the problem or a proper solution

### dinraal

- eww launches twice on system boot
  - *Status* Minor
    - easy to fix by running `eww kill` once after boot
  - doesn't happen on farosh
  - possibly residue in config files from older builds

### farosh

- bluetooth is inconsistent
  - *Status* Minor
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
