#!/usr/bin/env bash
set -euo pipefail

FLAKE_PATH="."
HOME_USER="misa"

# Determine the host configuration based on hostname
HOSTNAME=$(hostname)
case "$HOSTNAME" in
    "misa-nixos" | "nixos")
        SYSTEM_HOST="misa-nixos"
        ;;
    "misa-laptop")
        SYSTEM_HOST="misa-laptop"
        ;;
    *)
        echo "⚠️  Unknown hostname: $HOSTNAME"
        echo "Available configurations:"
        echo "  - misa-nixos (desktop)"
        echo "  - misa-laptop (laptop)"
        echo ""
        echo "Please specify the host configuration:"
        echo "Usage: $0 [host]"
        echo "Example: $0 misa-nixos"
        
        if [ $# -eq 1 ]; then
            SYSTEM_HOST="$1"
            echo "Using specified host: $SYSTEM_HOST"
        else
            exit 1
        fi
        ;;
esac

echo "🔄 Aktualizacja flake.lock..."
nix flake update --flake "$FLAKE_PATH"

echo "🛠️  Przełączanie konfiguracji systemu NixOS dla hosta: $SYSTEM_HOST..."
sudo nixos-rebuild switch --flake "$FLAKE_PATH#$SYSTEM_HOST"

echo "👤 Przełączanie konfiguracji użytkownika (Home Manager)..."
home-manager switch --flake "$FLAKE_PATH#$HOME_USER"

echo "✅ Gotowe! System i środowisko użytkownika zostały zaktualizowane."
