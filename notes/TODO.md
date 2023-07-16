# TODO

Originally a nice list of plans that has turned into a stream of conciousness mess of notes and tracking progress as I go. TODO - make into a proper TODO!

## Documentation

- README
  - [ ] rewrite install instructions
  - [ ] add section on steps to add new system
  - [ ] add steps on how to generate secrets
  - [x] add ways to contact for future friends
- secrets
  - [ ] README
  - [ ] comments
- hosts
  - [ ] README
  - [ ] comments
- modules
  - [ ] general README
  - [ ] comments
  - eww
    - [ ] README
    - [ ] comments

## Secrets

- [x] setup SOPS
- [ ] use SOPS for password instead of initialPassword
- [x] update and hide location in secrets
- [ ] look through config for anything else that should be secret
- [ ] consider changing username to fitz. (Not like its hard to find my real name. So I don't know if I really care)
  - would require
  - [ ] generate new ssh configs (probably extra, but why not)
  - [ ] transfer everything to new home directory on all systems
  - [ ] register new ssh keys for signon where applicable
  - [ ] confirm no funny business with ownership (should still be uid 1000)
- [ ] personal accounts in sops (email)
- [ ] hostnames in here?

## Impermanence

- [ ] research possible solutions
  - [ ] [Colin](https://git.uninsane.org/colin/nix-files) uses a homebrew FS module, looks very powerful, but I dont understand it yet
  - [ ] [Impermenence module](https://github.com/nix-community/impermanence) is more widely used and likely requires less maintenance
  - which is easier to use?
  - which is easier to understand for a third party?
  - which is better for me?
- [ ] implement selected solution

## Modules

### Email

- [ ] test out new thunderbird
- [ ] see if evolution can be declaratively configured

## Hosts

### General

- [ ] setup syncthing for each host to connect to external connections

### Dinraal

**Status** - Full NixOS

- [ ] set up split tunneling with wireguard so I have network access while away from home

### Farosh

**Status** - Full NixOS

### Naydra

**Status** - still running centOS (Next on Deck)
local NAS server which doubles as a local container host

- [ ] seperate out imports so server doesn't contain any desktop/unnecessary components
- write out new components
  - [ ] nfs client
  - [ ] nfs server (connect to farosh instead of sshd? Also can connect through split tunnel from dinraal)

### Gleeok

**Status** - still running debian

- [ ] remote vps which serves as a container host for internet exposed containers with uptime requirements. Can likely shift some internal and only accessable through wireguard.

### Otters *-- typo but I'm keeping it*

- RaspberryPi
  - [ ] consider if I have any use for this
    - does cec work with nixos? Probably can be made to
    - maybe lightweight computer/media player for tv?

- Router
  - [ ] networking is hard. is it easier on nix?
    - wouldn't mind dropping OPNSense
    - OTOH I am far from a networking expert. Would nixos even be secure on a router?

- Phone
  - [ ] pinephone seems like a fun toy
    - dont have one, but maybe someday!

## Containers

- [ ] test building container images using nix
- [ ] compare nix built images with ones on registry
- [ ] determine if custom images are even necessary
- can nixos give comparable isolation?
- do I care about isolation? (yes. for at least one)
- is having custom images worth the maintenance burden? (maybe)
- [ ] try building a version each image I currently use (8 of them left. too lazy to list rn)

## Research/Testing

- [ ] containers (as above)
- [ ] impermanence (as above)
- [ ] [nixos-router](https://github.com/chayleaf/nixos-router) vs current solution (OPNSense)
- [ ] [nixos-mailserver](https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/) vs current solution (bare metal on vps)
- [ ] thunderbird config
- [ ] flatpak. Is it more stable than FHS for electron apps? or Steam?
- [ ] nixos-stable then pull specific packages from unstable
  - potentially make things like steam/electron apps more stable
