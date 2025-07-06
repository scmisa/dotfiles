# NixOS Configuration

This repository contains my NixOS system configuration and Home Manager setup.

## Structure

```
├── flake.nix                     # Main flake configuration
├── flake.lock                   # Locked dependencies
├── .update.sh                   # Update script
├── README.md                    # This documentation
├── VIRTUALIZATION.md            # Virtualization setup guide
├── docker-compose.example.yml   # Example Docker Compose setup
├── virt-manager.sh              # Virtual machine manager script
├── nixos/
│   ├── configuration.nix        # Main NixOS configuration
│   └── hosts/
│       ├── desktop/             # Desktop-specific hardware config
│       └── laptop/              # Laptop-specific hardware config (not active)
└── home/
    └── misa.nix                # Home Manager configuration
```

## Usage

### First time setup on a new machine

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
   cp /etc/nixos/hardware-configuration.nix nixos/hosts/desktop/  # for desktop
   # cp /etc/nixos/hardware-configuration.nix nixos/hosts/laptop/  # for laptop (currently disabled)
   ```

4. **Update the flake** if needed (add new host configuration)
   
   Note: Currently only the desktop configuration (`misa-nixos`) is active. The laptop configuration is commented out in `flake.nix`.

5. **Run the update script**:

   ```bash
   ./.update.sh
   ```

### Regular updates

Simply run the update script:

```bash
./.update.sh
```

The script automatically detects your hostname and applies the correct configuration.

### Manual host selection

Currently only the desktop configuration is available:

```bash
./.update.sh misa-nixos    # for desktop
# ./.update.sh misa-laptop   # for laptop (currently commented out in flake.nix)
```

## Adding a new machine

1. Create a new folder in `nixos/hosts/` (e.g., `nixos/hosts/server/`)
2. Copy the hardware configuration from the new machine to that folder:
   ```bash
   sudo nixos-generate-config
   cp /etc/nixos/hardware-configuration.nix nixos/hosts/server/
   ```
3. Add the new host configuration to `flake.nix` in the `nixosConfigurations` section
4. Update the `.update.sh` script to recognize the new hostname
5. Test the configuration:
   ```bash
   ./.update.sh server-hostname
   ```

**Note**: Currently, the laptop configuration is commented out in `flake.nix`. To enable it, uncomment the `misa-laptop` section and ensure the hardware configuration is properly set up.

## Features

- **Modular configuration**: Shared system config with host-specific hardware configurations
- **Home Manager integration**: User-level package management and dotfiles
- **NixVim**: Neovim configuration through Nix
- **Gaming support**: Steam, Proton, and gaming tools
- **Development tools**: Rust toolchain, VS Code, terminal emulator
- **Virtualization support**: KVM, QEMU, and virt-manager setup (see `VIRTUALIZATION.md`)
- **Container support**: Docker and Docker Compose examples

## Additional Documentation

- **Virtualization Setup**: See `VIRTUALIZATION.md` for detailed VM and container setup instructions
- **Docker Examples**: Check `docker-compose.example.yml` for container orchestration examples
