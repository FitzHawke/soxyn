# TODO

Originally a nice list of plans that has turned into a stream of consciousness mess of notes and tracking progress as I go. TODO - make into a proper TODO!

## Documentation

- README
  - [x] rewrite install instructions
  - [ ] add section on steps to add new system
  - [x] add steps on how to re-generate secrets
  - [x] add ways to contact for future friends
- secrets
  - [x] README
  - [x] comments
- hosts
  - [ ] README
  - [ ] comments
- modules
  - [ ] general README
  - [ ] comments
  - eww
    - [ ] README
    - [ ] comments

## Impermanence

- [ ] research possible solutions
  - [ ] [Colin](https://git.uninsane.org/colin/nix-files) uses a homebrew FS module, looks very powerful, but I dont understand it yet
  - [ ] [Impermenence module](https://github.com/nix-community/impermanence) is more widely used and likely requires less maintenance
- [ ] implement selected solution

## Modules

### Email

- [ ] ~~test out new thunderbird~~
- [ ] ~~see if evolution can be declaratively configured~~

No email client for now. Gmail would be a pain.

## Hosts

### General

#### Syncthing

- [x] setup syncthing for each host
- [x] switch to agenix
- [ ] find out how to migrate device id across systems
- [ ] implement deviceID secrets into syncthing modules

### Dinraal

**Status** - Full NixOS

- [ ] set up split tunneling with wireguard so I have network access while away from home

### Farosh

**Status** - Full NixOS

### Naydra

**Status** - still running centOS (Next on Deck)
local NAS server which doubles as a local container host

- [ ] separate out imports so server doesn't contain any desktop/unnecessary components
- write out new components
  - [x] nfs client
  - [ ] nfs server (connect to farosh instead of sshd? Also can connect through split tunnel from dinraal)

### Gleeok

**Status** - still running debian

- [ ] remote vps which serves as a container host for internet exposed containers with uptime requirements. Can likely shift some internal and only accessible through wireguard.

### Otters *-- typo but I'm leaving it* 🦦

- RaspberryPi
  - [ ] consider if I have any use for this
    - does cec work with nixos? Probably can be made to
    - maybe lightweight computer/media player for tv?

- Router
  - [ ] networking is hard. is it easier on nix?
    - wouldn't mind dropping OPNSense
    - OTOH I am far from a networking expert. Would nixos *created by me* even be secure on a router?

- Phone
  - [ ] pinephone seems like a fun toy
    - don't have one, but maybe someday!

## Containers

- [ ] test building container images using nix
- [ ] compare nix built images with ones on registry
- [ ] compare images with straight up nix installs

- [ ] or just be super lazy and install a systemd service to build and run containers from a repo (podman is amazing! who really needs docker-compose anyways)
<https://docs.podman.io/en/latest/markdown/podman-generate-systemd.html#generate-systemd-unit-file-for-a-container-with-new-flag>

## Research/Testing

- [ ] containers (as above)
- [ ] impermanence (as above)
- [ ] [nixos-router](https://github.com/chayleaf/nixos-router) vs current solution (OPNSense)
- [ ] [nixos-mailserver](https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/) vs current solution (bare metal on vps)
- [ ] [Stalwart Mail Server](https://stalw.art/) could also work
- [x] thunderbird config
- [ ] flatpak. Is it more stable than FHS for electron apps? or Steam?
- [ ] nixos-stable then pull specific packages from unstable
  - potentially make things like steam/electron apps more stable
