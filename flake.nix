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
    # Configure nixpkgs to allow unfree packages
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        # Optionally, you can be more specific with:
        # allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "steam" "steam-run" "steam-original" ];
      };
    };
    pkgs-unstable = pkgs; # Since nixpkgs already points to unstable
  in {
    homeConfigurations = {
      misa = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./misa.nix
          nixvim.homeManagerModules.nixvim
        ];
        extraSpecialArgs = { 
          inherit pkgs-unstable nixvim; 
        };
      };
    };
  };
}