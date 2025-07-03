# NixOS Configuration

This repository contains my NixOS system configuration and Home Manager setup.

## Structure

```
├── flake.nix                 # Main flake configuration
├── flake.lock               # Locked dependencies
├── .update.sh               # Update script
├── nixos/
│   ├── configuration.nix    # Main NixOS configuration
│   └── hosts/
│       ├── desktop/         # Desktop-specific hardware config
│       └── laptop/          # Laptop-specific hardware config
└── home/
    └── misa.nix            # Home Manager configuration
```

## Usage

### First time setup on a new machine:

1. **Install NixOS** with flakes enabled
2. **Clone this repository**:
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

3. **Generate hardware configuration** for the new machine:
   ```bash
   # Run this on the new machine
   sudo nixos-generate-config
   
   # Copy the generated hardware config to the appropriate host folder
   cp /etc/nixos/hardware-configuration.nix nixos/hosts/laptop/  # or desktop/
   ```

4. **Update the flake** if needed (add new host configuration)

5. **Run the update script**:
   ```bash
   ./.update.sh
   ```

### Regular updates:

Simply run the update script:
```bash
./.update.sh
```

The script automatically detects your hostname and applies the correct configuration.

### Manual host selection:

If you want to force a specific host configuration:
```bash
./.update.sh misa-nixos    # for desktop
./.update.sh misa-laptop   # for laptop
```

## Adding a new machine

1. Create a new folder in `nixos/hosts/` (e.g., `nixos/hosts/server/`)
2. Copy the hardware configuration from the new machine to that folder
3. Add the new host configuration to `flake.nix`
4. Update the `.update.sh` script to recognize the new hostname

## Features

- **Modular configuration**: Shared system config with host-specific hardware configurations
- **Home Manager integration**: User-level package management and dotfiles
- **NixVim**: Neovim configuration through Nix
- **Gaming support**: Steam, Proton, and gaming tools
- **Development tools**: Rust toolchain, VS Code, terminal emulator
