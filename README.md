# Soxyn - NixOS configurations - *Stability Guaranteed or your Money Back*

This repository contains my personal NixOS configurations, built using flakes. It provides a declarative and reproducible way to define and manage my system configuration.

## 📑 Table of Contents

- [Introduction](#-introduction)
  - [Features](#-features)
  - [Limitations](#-limitations)
  - [Future](#-future)
- [Getting Started](#-getting-started)
  - [Pre-Install](#-pre-install)
  - [Setup](#-setup)
  - [Partitioning](#-partitioning)
    - [Encrypted](#-full-disk-encryption-with-luks)
    - [Non-Encrypted](#-no-encryption)
  - [Install](#-install)
  - [Customization](#-customization)
  - [Updating](#-updating)
- [Contributing](#-contributing)
- [Contact](#-contact)
- [License](#-license)
- [Special Thanks](#-special-thanks)
- [The Rabbit Hole](#-the-rabbit-hole)

## 👋 Introduction

NixOS is a Linux distribution that provides a purely functional approach to system configuration management. With NixOS, the entire operating system, including packages, libraries, and configuration files, is built using the Nix package manager.

This repository contains my personal NixOS configurations, tailored to my specific needs and preferences. It aims to provide a solid foundation for my development environment, system settings, and installed packages.

My goal is to evolve that configuration to have less manual setup on install (more imperative) and have more things synced between systems (or through the cloud). Basically the dream is to eliminate configuration drift.

### 🗺 Layout

- [Assets](./assets) - extra files like desktop images and readme images
- [Hosts](./hosts) - Contains all unique host configurations
  - [By-id](./hosts/by-id) - configuration settings unique to each individual host
  - [Shared](./hosts/shared) - configuration settings shared between hosts
    - [Core](./hosts/shared/core/) - configuration modules for the root system
    - [Home](./hosts/shared/home/) - configuration modules to be imported inside of home-manager
    - [Meta](./hosts/shared/meta/) - groupings of configuration modules, ie. desktop environments
    - [Users](./hosts/shared/users/) - configuration modules for users
- [Modules](./modules) - modules that add additional configuration options
- [Notes](./notes) - additional notes mostly to myself, not available in comments or readmes. *Likely contains outdated information*
- [Secrets](./secrets) - ssh pubkeys and information to be decrypted on system bootup

### ✅ Features

- Built with flakes for reproducibility and declarative configuration.
- Modular configuration structure for easy organization and customization.
- Includes common system settings, user configuration, and package installations.
- Supports multiple hardware configurations and profiles.
- Provides a convenient way to manage dotfiles and additional customizations.

### ⚠ Limitations

- Everything built around single user
  - currently no nice way to build multi-user version of systems
- Limited machine specific config
- cli greeter, using vulkan backend for sway breaks gui greeters with my graphics cards
- hyper-optimized to my specific use cases
- secure boot is not used with this image. You will need to ensure it is disabled in your hardware bios

### 🗓 Future

- reduce the above limitations
- add more hosts
  - Naydra (NAS currently with containers)
  - Gleeok (VPS currently with mail-server/more containers)
  - rpi - any use for this with nix?
  - router - currently OPNSense. Consider trying nixos-router project
- impermanence <- wipe the system every reboot and only persist necessary data
- build container images with nixos
- build install iso
- PROPER documentation
  - if anyone somehow stumbles across this greasy little horror show then lets make their life a little easier, nix can be so confusing!
  - also for me as I'll forget why I did half the things I did 😅
    - add comments throughout
    - add READMEs in each major section to explain choices/motivations

For more detailed plans see [TODO](./notes/TODO.md)

## 🥽 Getting Started

### 📌 Pre-Install

You have 2 options here, clone the repo locally (for private repos) or install directly from github! *Note: you will either need to fork the repo or clone in order to edit the secrets for your system.*

Coming soon a generic image that avoids all secrets or has better instructions to replace them.

Currently secrets are used at:

- syncthing `hosts/${hostName}/syncthing.nix`
  - can remove import syncthing in `hosts/default.nix`
- location for wlsunset `modules/home/hyprland/default.nix`
  - can just replace env variables with hardcoded values
- password and ssh keys `modules/core/users.nix`
  - can replace password with initialPassword then change it on first login
  - ssh key is loaded as an authorized key for ssh login. not needed as long as you are confident in your password setup

### 📐 Setup

1. Download an iso image from <https://nixos.org/download.html#nixos-iso> and write the image to a usb stick.

    ```bash
    wget -O nixos.iso https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso

    # Write it to a flash drive
    sudo dd if=nixos.iso of=/dev/sdX bs=4M conv=fsync
    ```

    **Warning:** dd is an old school cloning utility without guardrails. It will happily overwrite anything you tell it to. Be careful with the `of=/dev/sdX` portion.

    See [here](https://nixos.org/manual/nixos/stable/index.html#sec-booting-from-usb) or [here](https://wiki.archlinux.org/title/USB_flash_installation_medium) for more info on writing the USB.

2. Boot into the installer. Instructions vary based on hardware, but basically find the boot menu by pressing something like `F12` or `DEL` during the splash screen.

3. Switch to root user and mentally prepare yourself for manually formatting: `sudo -i` + 🧘

### 🪚 Partitioning

We have written up instructions for 2 different partition schemas below, one with [full disk encryption](#-full-disk-encryption-with-luks) (requires decryption password entry on boot) and one [without encryption](#-no-encryption). We recommend using encryption on any devices you travel with or devices with private information you'd like to keep secure.

We are using btrfs on a nvme ssd with UEFI boot and no swap partition for the following examples.

- If you'd like to use ext4 then you will need to adjust the formatting section to include creating partitions for all volumes, rather than just one root and then using sub-volumes.
- If you're using a HDD instead of NVME then you'll have to replace references to `/dev/nvmeXn1pX` with `/dev/sdXX` where the 1st `X` represents the drive id and the second `X` corresponds to the partition number.
- Another option if you are on linux already is to keep your partitioning and manually install in place or use [nixos-infect](https://github.com/elitak/nixos-infect), but those are not recommended and go beyond the scope of this guide.
- if you'd like to use swap then you'll require some small changes to the partitioning and formatting. The [official docs](https://nixos.org/manual/nixos/stable/index.html#sec-installation-manual-partitioning) follow format similarly and should provide a good example.
- Nix can also run as a package manager on non nixOS distributions, not requiring any of this partitioning nonsense, but currently none of the systems in this repo are setup for that use case. Get in contact if you'd like to experiment!

#### 🔑 Full Disk Encryption with LUKS

   We create a root partition (`/dev/nvme0n1p1`) encrypted with LUKS, with a single volume formatted with btrfs having 3 sub-volumes (`/`, `/nix`, `/home`) and a 512MB EFI boot partition (`/dev/nvme0n1p2`) needed for UEFI.

   ```bash
   # create partition table
   parted /dev/nvme0n1 -- mklabel GPT

   # create root partition
   parted /dev/nvme0n1 -- mkpart primary 512MB 100%
   parted /dev/nvme0n1 -- set 1 lvm on

   # create the boot partition
   parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 512MB
   parted /dev/nvme0n1 -- set 2 esp on

   # setup and open encrypted LUKS partition
   cryptsetup luksFormat /dev/nvme0n1
   cryptsetup luksOpen /dev/nvme0n1 luks

   # format the boot partition (labeled BOOT)
   mkfs.fat -F 32 -n BOOT /dev/nvme0n1p2

   # format the root with btrfs (labeled NIXOS)
   mkfs.btrfs -L NIXOS /dev/mapper/luks

   # mount the btrfs volume at /mnt
   mount -t btrfs /dev/mapper/luks /mnt

   # create the sub-volumes
   btrfs subvolume create /mnt/root
   btrfs subvolume create /mnt/home
   btrfs subvolume create /mnt/nix

   # unmount the volume
   umount /mnt

   # re-mount the root sub-volume
   mount -o subvol=root,autodefrag,compress=zstd,discard=async /dev/mapper/luks /mnt

   # create the mount directories
   mkdir -p /mnt/{home,nix,boot}

   # mount the other sub-volumes
   mount -o subvol=home,autodefrag,compress=zstd,discard=async /dev/mapper/luks /mnt/home
   mount -o subvol=nix,autodefrag,compress=zstd,discard=async /dev/mapper/luks /mnt/nix

   # Mount boot partition
   mkdir /mnt/boot
   mount /dev/nvme0n1p2 /mnt/boot
   ```

Whew, finally done partitioning setup! Now you can skip down to [Install](#-install) for the next steps.

#### 🔓 No Encryption

   We create a root partition (`/dev/nvme0n1p1`) formatted with btrfs having 3 sub-volumes (`/`, `/nix`, `/home`) and a 512MB EFI boot partition (`/dev/nvme0n1p2`) needed for UEFI.

   ```bash
   # create partition table
   parted /dev/nvme0n1 -- mklabel GPT

   # create root partition
   parted /dev/nvme0n1 -- mkpart primary 512MB 100%

   # create the boot partition
   parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 512MB
   parted /dev/nvme0n1 -- set 2 esp on

   # format the boot partition (labeled BOOT)
   mkfs.fat -F 32 -n BOOT /dev/nvme0n1p2

   # format the root with btrfs (labeled NIXOS)
   mkfs.btrfs -L NIXOS /dev/nvme0n1p1

   # mount the btrfs volume at /mnt
   mount -t btrfs /dev/nvme0n1p1 /mnt

   # create the sub-volumes
   btrfs subvolume create /mnt/root
   btrfs subvolume create /mnt/home
   btrfs subvolume create /mnt/nix

   # unmount the volume
   umount /mnt

   # re-mount the root sub-volume
   mount -o subvol=root,autodefrag,compress=zstd,discard=async /dev/nvme0n1p1 /mnt

   # create the mount directories
   mkdir -p /mnt/{home,nix,boot}

   # mount the other sub-volumes
   mount -o subvol=home,autodefrag,compress=zstd,discard=async /dev/nvme0n1p1 /mnt/home
   mount -o subvol=nix,autodefrag,compress=zstd,discard=async /dev/nvme0n1p1 /mnt/nix

   # Mount boot partition
   mkdir /mnt/boot
   mount /dev/nvme0n1p2 /mnt/boot
   ```

Whew, finally done partitioning setup! Now you can skip down to [Install](#-install) for the next steps.

### 💻 Install

Now we can finally do the install!

   ```bash
   # ensure flakes are enabled on the system
   nix-shell -p nixFlakes

   # generate a hardware-configuration.nix for your specific hardware
   nixos-generate-config --root /mnt --dir hosts/by-id/korok/

   # make sure git is tracking the changes
   git add hosts/korok/hardware-configuration.nix
   ```

   We can either install directly or from a git repository

   ```bash
   # install the flake
   nixos-install --flake '.#korok' # github:fitzhawke/soxyn#korok
   ```

Now reboot and login! *Don't forget to change your password if you used initialPassword*

### 💡 Customization

To customize your NixOS configuration, you can:

- Edit the existing configuration files to modify system settings or package installations.
- Create new NixOS modules in the `modules` directory and import them into the main configuration files.

The modular structure of this configuration repository allows you to easily organize and extend your setup according to your preferences.

### 🚀 Updating

To update your NixOS configuration while on the system, run the following

```bash
# enter the nixos repo
cd ~/workspaces/soxyn # replace with where you store your config

# ensure all files are tracked by git
git add .

# update the flake inputs if you'd like
nix flake update

# test the new configuration if you'd like
sudo nixos-rebuild test --flake .#dinraal

# build and install the new config
sudo nixos-rebuild switch --flake .#dinraal
```

## 🔨 Contributing

Contributions are welcome! If you have any suggestions, improvements, or bug fixes, please open an issue or submit a pull request.

When contributing, please ensure that your changes align with the existing code style and conventions.

## 🚜 Contact

If you have any questions about the how or why of anything in here then please don't hesitate to reach out! Or even just if you found value and want to say thanks, I'd love to hear from you! I can be reached through any of the links below:

- Email - [will.featherston@gmail.com](mailto:will.featherston@gmail.com)
- Matrix - [@fitzhawke:matrix.org](https://matrix.to/#/@fitzhawke:matrix.org)
- LinkedIn - [Will Featherston](https://www.linkedin.com/in/will-featherston/)

These work too, but not as actively monitored

- Twitter - [@FitzHawke](https://twitter.com/FitzHawke)

If none of the above work you can always open an issue here too! 😄

## 📜 License

This project is licensed under the [MIT License](./LICENCE.md). Feel free to use and modify the configurations as you see fit.

## ❤ Special Thanks

A list of people whose amazing configs served as a reference while I fumbled my way through building my own. I love you all!

- [Colin (uninsane)](https://git.uninsane.org/colin/nix-files)
- [n3oney](https://github.com/n3oney/nixus)
- [fufexan](https://github.com/fufexan/dotfiles)
- [NotAShelf](https://github.com/NotAShelf/nyx)
- [sioodmy](https://github.com/sioodmy/dotfiles)
- [Misterio77](https://github.com/Misterio77/nix-config)
- [rxyhn](https://github.com/rxyhn/yuki)

And the countless others that have both supported and tolerated my shenanigans.

## 🐇 The Rabbit Hole

### 🧭 More of Me

Take a look at some of my other projects!

- My [website](https://fitzhawke.com) is currently a single page portfolio page made with React and Astro. I had a lot of fun making this one, and am excited for its next evolution. A blog. Coming Soon(ish)
- [PEFS](https://pefson.cyclic.sh) a custom built fitness tracker with thew intent of easy data entry and beautiful data representations.
- Ask me about all the networks I've built or programs I've hosted over the years. It's quite a list, ranging from setting up a wireless point-to-point network (Wifi throughout the barn?! Amazing!) to running my own email server (Fun, but I don't recommend doing it seriously)

### 📣 Shout-outs

For more yet, check out what these brilliant devs are up to!

- [Jarrod](https://github.com/jarrodmjack)
- [Ned](https://github.com/ned-park)
- [DVKR](https://github.com/3dvkr)
- [Jamil](https://github.com/jamilsinno)
