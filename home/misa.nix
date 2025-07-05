{ config, pkgs, lib, ... }:

{
  home.username = "misa";
  home.homeDirectory = "/home/misa";
  home.stateVersion = "25.05";

  imports = [];  # już zaimportowane flake

  # Allow Steam to manage its own files
  # Remove the Steam file exclusions that can cause startup issues

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      expandtab = true;
      tabstop = 2;
    };
    
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "macchiato";
    };
    
    plugins.lightline.enable = true;
  };

  programs.kitty = {
    enable = true;

    font = {
      name = "FiraCode Nerd Font";
      size = 13;
    };

    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      background_opacity = "0.9";
    };

    keybindings = {
      "ctrl+shift+n" = "new_os_window";
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    kitty  # (jeśli nie masz systemowo)
    
    # Rust development tools
    rustc
    cargo
    rustfmt
    rust-analyzer
    clippy

    # Gaming - Steam and Proton
    steam
    steam-run
    protonup-qt       # Proton GE manager
    protontricks      # Tool for managing Proton prefixes
    gamemode          # Optimize system performance for gaming
    mangohud          # Gaming performance overlay
    lutris            # Game manager
    wine              # For running Windows games
    winetricks        # Helper scripts for Wine
    
    # Libraries for gaming and Steam compatibility
    giflib
    libpng
    gnutls
    mpg123
    openal
    vulkan-tools
    vulkan-loader
    vulkan-headers
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXScrnSaver
    libpulseaudio
    libGL
    glxinfo
  ];
  
  programs.home-manager.enable = true;
}