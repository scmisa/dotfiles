{ config, pkgs, lib, ... }:

{
  home.username = "misa";
  home.homeDirectory = "/home/misa";
  home.stateVersion = "25.05";

  imports = [];  # już zaimportowane flake

  # ZSH configuration for Home Manager
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "docker" "kubectl" "rust" "fzf" ];
    };
    
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
      nixos-rebuild = "sudo nixos-rebuild switch --flake /home/misa/dotfiles#misa-nixos";
      hm-switch = "home-manager switch --flake /home/misa/dotfiles#misa";
    };
    
    # Add cargo completions and other shell enhancements
    initContent = ''
      # Enable cargo completions
      if command -v cargo >/dev/null 2>&1; then
        eval "$(cargo --zsh-completion 2>/dev/null || true)"
      fi
      
      # Enable rustup completions
      if command -v rustup >/dev/null 2>&1; then
        eval "$(rustup completions zsh 2>/dev/null || true)"
      fi
    '';
  };

  # FZF configuration
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "find . -type f";
    defaultOptions = [
      "--height 40%"
      "--border"
      "--reverse"
      "--preview 'bat --style=numbers --color=always {}'"
    ];
  };

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
      shell = "${pkgs.zsh}/bin/zsh";
    };

    keybindings = {
      "ctrl+shift+n" = "new_os_window";
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    kitty  # (jeśli nie masz systemowo)
    
    # Command line tools
    fzf
    bat
    fastfetch
    
    
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

    # Hacking and reverse engineering research tools
    radare2           # Reverse engineering framework
    ghidra            # Software reverse engineering tool
    binwalk           # Firmware analysis tool
    gdb               # GNU Debugger
    strace            # Trace system calls and signals
    ltrace            # Trace library calls
    tcpdump           # Network packet analyzer
    nmap              # Network exploration tool and security scanner
    wireshark         # Network protocol analyzer
    aircrack-ng       # Suite of tools for assessing WiFi network security
    hydra             # Network logon cracker
    john              # Password cracking software
    # sqlmap            # Automatic SQL injection and database takeover tool - temporarily disabled due to Python compatibility
    metasploit        # Penetration testing framework
    burpsuite         # Web application security testing tool
    # pysqlrecon        # Offensive MSSQL toolkit - temporarily disabled due to Python compatibility
    # python312Packages.hakuin  # Blind SQL Injection optimization framework - temporarily disabled due to Python compatibility
    # commix            # Automated Command Injection Exploitation Tool - temporarily disabled due to Python compatibility
    # nosqli            # NoSQL injection tool for MongoDB - temporarily disabled due to Python compatibility
    dalfox            # XSS scanning and analysis tool
    # nikto             # Web server scanner - temporarily disabled due to Python compatibility  
    # wpscan            # WordPress security scanner - temporarily disabled due to Python compatibility
    dirb              # Web content scanner
    gobuster          # Directory/file/DNS brute-forcer
    ffuf              # Web fuzzer
    hashcat           # Advanced password cracker
    exiftool          # Metadata reader and editor
    binutils          # Collection of binary tools
    ghex              # Hex editor
    htop              # Interactive process viewer

    # Additional Applications
    vlc             # VideoLAN Client (VLC) media player
    gimp            # GNU Image Manipulation Program
    inkscape        # Vector graphics editor
    libreoffice     # Office suite
    signal-desktop  # Encrypted messaging app
    spotify         # Music streaming service
    obs-studio      # Open Broadcaster Software for video recording and live streaming

    # Other useful apps
    keepassxc       # Password manager
    transmission-gtk # BitTorrent client
    mpv             # Media player

  ];
  
  programs.home-manager.enable = true;
}