# NixOS configuration

_Yoyomanzoor_

### Organization

- shared configurations in `./base/`
- per-hardware configurations in `./hosts/`
- per-DE configurations in `./desktop-environments/`

Flake is organized as:

- PC_1
    - DE_1
    - DE_2
- PC_2
    - DE_1
    - DE_2
- etc

So build commands are:

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
