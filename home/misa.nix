{ config, pkgs, lib, ... }:

{
  home.username = "misa";
  home.homeDirectory = "/home/misa";
  home.stateVersion = "25.05";

  imports = [];  # już zaimportowane flake

  # More comprehensive exclusions for Steam files
  home.file = {
    ".steam".enable = false;
    ".local/share/Steam".enable = false;
  };
  
  # Correctly formatted activation script
  home.activation.excludeSteamFiles = lib.hm.dag.entryBefore ["linkGeneration"] ''
    rm -f ~/.steam/steam.pipe ~/.steam/root/steam.pipe 2>/dev/null || true
  '';

  # Auto-start Steam when logging in (optional)
  xdg.configFile."autostart/steam.desktop".source = "${pkgs.steam}/share/applications/steam.desktop";

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
    
    # Libraries for gaming
    giflib
    libpng
    gnutls
    mpg123
    openal
    vulkan-tools
    vulkan-loader
    vulkan-headers
  ];
  
  programs.home-manager.enable = true;
}