# Virtualization and Containerization Setup

This configuration includes Docker, QEMU/KVM, and LXD for containerization and virtualization.

## What's Configured

### Docker
- Docker daemon with rootless mode enabled
- Docker Compose for multi-container applications
- Shell aliases for common Docker commands
- Auto-completion for Docker commands

### QEMU/KVM
- Full virtualization support with KVM acceleration
- OVMF UEFI firmware support
- libvirtd service for VM management
- virt-manager GUI for VM creation and management

### LXD
- Linux containers for lightweight virtualization
- Networking configured for container access

## Quick Start

### After NixOS Rebuild

1. **Rebuild your system:**
   ```bash
   nixos-rebuild switch --flake /home/misa/dotfiles#misa-nixos
   ```

2. **Apply home manager configuration:**
   ```bash
   home-manager switch --flake /home/misa/dotfiles#misa
   ```

3. **Reboot or re-login** to ensure all group memberships are active.

4. **Check system status:**
   ```bash
   ./virt-manager.sh system-info
   ```

### Docker Usage

1. **Start Docker:**
   ```bash
   ./virt-manager.sh docker-start
   ```

2. **Test Docker:**
   ```bash
   docker run hello-world
   ```

3. **Use Docker Compose:**
   ```bash
   # Copy the example compose file
   cp docker-compose.example.yml ~/my-project/docker-compose.yml
   cd ~/my-project
   dcup  # Start services
   ```

### Virtual Machines (QEMU/KVM)

1. **Check VM status:**
   ```bash
   ./virt-manager.sh vm-status
   ```

2. **Open virt-manager GUI:**
   ```bash
   virt-manager
   ```

3. **List VMs from command line:**
   ```bash
   ./virt-manager.sh vm-list
   ```

### LXD Containers

1. **Initialize LXD (run once):**
   ```bash
   ./virt-manager.sh lxd-init
   ```

2. **Create your first container:**
   ```bash
   lxc launch ubuntu:22.04 my-container
   lxc exec my-container -- bash
   ```

3. **Check LXD status:**
   ```bash
   ./virt-manager.sh lxd-status
   ```

## Useful Aliases

The following aliases are configured in your shell:

### Docker
- `dps` - docker ps
- `dpsa` - docker ps -a
- `di` - docker images
- `dcp` - docker-compose
- `dcup` - docker-compose up -d
- `dcdown` - docker-compose down
- `dclogs` - docker-compose logs -f

### Kubernetes
- `k` - kubectl
- `kgp` - kubectl get pods
- `kgs` - kubectl get services
- `kgd` - kubectl get deployments
- `kdesc` - kubectl describe

### Virtualization
- `vms` - virsh list --all
- `vmstart` - virsh start
- `vmstop` - virsh shutdown

## Troubleshooting

### Permission Issues
If you get permission denied errors, ensure you're in the correct groups:
```bash
groups
# Should show: docker libvirtd lxd kvm
```

If not, reboot or re-login after the NixOS rebuild.

### Docker Issues
- Start Docker service: `./virt-manager.sh docker-start`
- Clean up Docker: `./virt-manager.sh docker-clean`

### KVM Issues
- Check if KVM is available: `ls /dev/kvm`
- Check virtualization support: `./virt-manager.sh system-info`

### LXD Issues
- Initialize LXD: `./virt-manager.sh lxd-init`
- Check LXD status: `./virt-manager.sh lxd-status`

## Security Notes

- Docker is configured with rootless mode for better security
- The user is added to necessary groups for virtualization access
- Firewall reverse path checking is disabled for container networking

## Next Steps

1. Try running some containers with Docker
2. Create a virtual machine using virt-manager
3. Experiment with LXD containers
4. Set up a development environment using Docker Compose
