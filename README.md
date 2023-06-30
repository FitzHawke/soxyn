# Soxyn - My NixOS configurations - *Stability Guarenteed or your Money Back*

This repository contains my personal NixOS configurations, built using flakes. It provides a declarative and reproducible way to define and manage my system configuration.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
- [Configuration](#configuration)
- [Customization](#customization)
- [Contributing](#contributing)
- [License](#license)
- [Special Thanks](#special-thanks)

## Introduction

NixOS is a Linux distribution that provides a purely functional approach to system configuration management. With NixOS, the entire operating system, including packages, libraries, and configuration files, is built using the Nix package manager.

This repository contains my personal NixOS configurations, tailored to my specific needs and preferences. It aims to provide a solid foundation for my development environment, system settings, and installed packages.

## Features

- Built with flakes for reproducibility and declarative configuration.
- Modular configuration structure for easy organization and customization.
- Includes common system settings, user configuration, and package installations.
- Supports multiple hardware configurations and profiles.
- Provides a convenient way to manage dotfiles and additional customizations.

## Getting Started

### Prerequisites

Before using these configurations, make sure you have the following prerequisites installed on your system:

- [Nix](https://nixos.org/download.html) - The Nix package manager.

### Installation

1. Clone this repository to your local machine:

   ```shell
   $ git clone https://github.com/yourusername/your-repo-name.git
   ```

2. Change to the repository directory:

   ```shell
   $ cd your-repo-name
   ```

3. Build and activate the NixOS system configuration:

   ```shell
   $ nixos-rebuild switch --flake .
   ```

   This command will build and activate the NixOS system configuration defined in `flake.nix` and `nixos/configuration.nix`.

### Usage

- To rebuild and activate the configuration:

  ```shell
  $ nixos-rebuild switch --flake .
  ```

- To update the system and installed packages:

  ```shell
  $ nixos-rebuild switch --upgrade
  ```

- To rollback to the previous configuration:

  ```shell
  $ nixos-rebuild boot --rollback
  ```

## Configuration

The main configuration files can be found in the `hosts` and `modules` directories. The `modules/core` directory defines the system-wide configuration, while the `modules/home` directory contains user-specific configurations.

Feel free to modify and extend these files to suit your needs. Add or remove packages, tweak system settings, or create new modules as necessary.

## Customization

To customize your NixOS configuration, you can:

- Edit the existing configuration files to modify system settings or package installations.
- Create new NixOS modules in the `modules` directory and import them into the main configuration file.

The modular structure of this configuration repository allows you to easily organize and extend your setup according to your preferences.

## Contributing

Contributions are welcome! If you have any suggestions, improvements, or bug fixes, please open an issue or submit a pull request.

When contributing, please ensure that your changes align with the existing code style and conventions.

## License

This project is licensed under the [MIT License](./LICENCE.md). Feel free to use and modify the configurations as you see fit.

## Special Thanks

A list of people whose amazing configs served as a reference while I fumbled my way through building my own. I love you all!

- [Colin (uninsane)](https://git.uninsane.org/colin/nix-files)
- [n3oney](https://github.com/n3oney/nixus)
- [fufexan](https://github.com/fufexan/dotfiles)
- [NotAShelf](https://github.com/NotAShelf/nyx)
- [sioodmy](https://github.com/sioodmy/dotfiles)
- [Misterio77](https://github.com/Misterio77/nix-config)
