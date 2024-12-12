# NixOS configuration

_Yoyomanzoor_

### Install

Once NixOS is installed, there are two possibilities:

1. The same PC/hardware has been used in a previous install, in which case this configuration would work out of the box. See `./hosts/` for the available hosts.
2. The PC has been used a host in the past. In order to seamlessly install the same packages and environment, a few steps will be required:
    - Create a new host folder and copy `/etc/nixos/hardware-configuration.nix` to that folder
    - Add a host to the flake file (just copy the lenovo-yoga hosts and rename paths accordingly)
    - Create a `configuration.nix` file to the host folder, with just the following: `{imports = [./hardware-configuration.nix]; }`
    - Follow build commands below

### Organization

- shared configurations in `./base/`
- per-hardware configurations in `./hosts/`
- per-DE configurations in `./desktop-environments/`
- coding tools in `./code/`
- home configs called by `home.nix` all in `./dotfiles/`
- wallpapers in `./wallpapers/`, need to be moved to `./wallpaper.png` to be used

Flake is organized as:

- PC_1
    - DE_1
    - DE_2
- PC_2
    - DE_1
    - DE_2
- etc

### Build commands

```bash
sudo nixos-rebuild switch --flake ~/(location-of-this-repo)#(PC)-(DE)
```

For example, to build on Lenovo Slim 7 with gnome, the command would be:

```bash
sudo nixos-rebuild switch --flake ~/.config/nixos#lenovo-yoga-gnome
```

### Random useful things

Clean commands

```bash
nix-store --gc
sudo nix-collect-garbage --delete-older-than 15d
```

### TODO

- [ ] A simpler way to change wallpapers
- [ ] Arabic keyboard
- [ ] Eventually move [configs](https://www.github.com/Yoyomanzoor/dotfiles.git) to home-manager

