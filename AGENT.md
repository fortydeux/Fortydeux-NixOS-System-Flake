# AGENT.md - Fortydeux NixOS Flake

## Build/Test Commands
- **Build NixOS system**: `sudo nixos-rebuild switch --flake .#<host>-nixos` (hosts: archerfish, killifish, pufferfish, blackfin, blacktetra)
- **Build Home Manager**: `nix run home-manager/master -- switch --flake .#fortydeux@<host>-nixos`
- **Generate hardware config**: `sudo nixos-generate-config --show-hardware-config > nixos-config/hosts/<host>/hardware-configuration.nix`
- **Check syntax**: `nix flake check`
- **Update flake inputs**: `nix flake update`

## Architecture
- Multi-host NixOS flake supporting 5 systems (archerfish, killifish, pufferfish, blackfin, blacktetra)
- **nixos-config/**: System-level NixOS configurations per host
- **home-manager/**: User-level configurations and dotfiles
- **home-manager/dotfiles/**: Raw config files written to $HOME/.config/
- Key WMs: Hyprland (primary), KDE Plasma, River, Sway, Wayfire
- Uses Flakehub for most inputs, includes Hyprland, Stylix, musnix

## Code Style
- Nix expressions use 2-space indentation
- Host configs in separate directories under nixos-config/hosts/ and home-manager/hosts/
- Dotfiles managed via home.files function, not as inline Nix strings
- Module imports follow pattern: `./path/to/module.nix`
- Special args passed via `specialArgs = { inherit inputs; }`
- Home Manager configs use `extraSpecialArgs = { inherit inputs; }`
