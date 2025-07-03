# Hardware configuration for laptop
# This file should be generated on the laptop using: nixos-generate-config
# Then copy the generated /etc/nixos/hardware-configuration.nix here

{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # TODO: Replace with actual laptop hardware configuration
  # Run `nixos-generate-config` on the laptop and copy the generated file here
  
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
