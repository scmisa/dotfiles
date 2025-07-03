{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixvim.url = "github:nix-community/nixvim";
    
    # Make dependencies follow the main nixpkgs
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }:
  let 
    system = "x86_64-linux"; 
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-unstable = pkgs;
  in {
    # ✅ SYSTEM
    nixosConfigurations = {
      # Desktop configuration
      misa-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          ./nixos/hosts/desktop/hardware-configuration.nix
          home-manager.nixosModules.home-manager
        ];
        specialArgs = { inherit pkgs-unstable nixvim; };
      };
      
      # Laptop configuration
      misa-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          ./nixos/hosts/laptop/hardware-configuration.nix
          home-manager.nixosModules.home-manager
        ];
        specialArgs = { inherit pkgs-unstable nixvim; };
      };
    };

    # ✅ UŻYTKOWNIK
    homeConfigurations = {
      misa = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/misa.nix
          nixvim.homeManagerModules.nixvim
        ];
        extraSpecialArgs = { inherit pkgs-unstable nixvim; };
      };
    };
  };
}
