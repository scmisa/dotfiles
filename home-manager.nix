{ config, pkgs, ... }:

{
  home.username = "misa";
  home.homeDirectory = "/home/misa";
  home.stateVersion = "25.05";

  imports = [];  # już zaimportowane flake

  programs.nixvim = {
    enable = true;
    options = {
      number = true;
      relativenumber = true;
      colorschemes.gruvbox.enable = true;

      shiftwidth = 2;
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
    fira-code-nerdfont
    kitty  # (jeśli nie masz systemowo)
    neovim
  ];
  programs.home-manager.enable = true;
}