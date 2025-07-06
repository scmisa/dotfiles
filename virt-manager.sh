#!/usr/bin/env bash

# Virtualization Management Script
# This script helps you manage Docker, QEMU/KVM, and LXD

show_help() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  docker-status     Show Docker service status"
    echo "  docker-start      Start Docker service"
    echo "  docker-clean      Clean up Docker (remove unused containers, images, etc.)"
    echo "  vm-list          List all virtual machines"
    echo "  vm-status        Show libvirtd status"
    echo "  lxd-status       Show LXD status"
    echo "  lxd-init         Initialize LXD (run once)"
    echo "  system-info      Show virtualization capabilities"
    echo "  help             Show this help message"
}

docker_status() {
    echo "=== Docker Status ==="
    systemctl status docker.service --no-pager -l
    echo ""
    echo "=== Docker Containers ==="
    docker ps -a
    echo ""
    echo "=== Docker Images ==="
    docker images
}

docker_start() {
    echo "Starting Docker service..."
    sudo systemctl start docker.service
    sudo systemctl enable docker.service
}

docker_clean() {
    echo "Cleaning up Docker..."
    docker system prune -a --volumes
}

vm_list() {
    echo "=== Virtual Machines ==="
    virsh list --all
}

vm_status() {
    echo "=== Libvirtd Status ==="
    systemctl status libvirtd.service --no-pager -l
}

lxd_status() {
    echo "=== LXD Status ==="
    systemctl status lxd.service --no-pager -l
    echo ""
    echo "=== LXD Containers ==="
    lxc list 2>/dev/null || echo "LXD not initialized or no containers"
}

lxd_init() {
    echo "Initializing LXD..."
    sudo lxd init
}

system_info() {
    echo "=== Virtualization Capabilities ==="
    echo "KVM support:"
    if [ -e /dev/kvm ]; then
        echo "  ✓ /dev/kvm exists"
    else
        echo "  ✗ /dev/kvm not found"
    fi
    
    echo "Loaded kernel modules:"
    lsmod | grep -E "(kvm|vfio|vhost)"
    
    echo ""
    echo "CPU virtualization features:"
    grep -E "(vmx|svm)" /proc/cpuinfo >/dev/null && echo "  ✓ Hardware virtualization supported" || echo "  ✗ Hardware virtualization not detected"
    
    echo ""
    echo "User groups:"
    groups | grep -E "(docker|libvirtd|lxd|kvm)" || echo "  User not in virtualization groups"
}

case "$1" in
    docker-status)
        docker_status
        ;;
    docker-start)
        docker_start
        ;;
    docker-clean)
        docker_clean
        ;;
    vm-list)
        vm_list
        ;;
    vm-status)
        vm_status
        ;;
    lxd-status)
        lxd_status
        ;;
    lxd-init)
        lxd_init
        ;;
    system-info)
        system_info
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac
