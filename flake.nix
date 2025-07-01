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
    pkgs = nixpkgs.legacyPackages.${system};
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