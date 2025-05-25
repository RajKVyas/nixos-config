# /home/raj/nixos-config/home/raj/home.nix
{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "raj";
  home.homeDirectory = "/home/raj";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Matching your system's stateVersion intent.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # User-specific packages. We will migrate packages from users.nix here later.
  home.packages = with pkgs; [
    # Examples:
    # neovim
    # zsh
    # Utilities
    brightnessctl
    cliphist
    lshw # List hardware
    neofetch
    pavucontrol # PulseAudio Volume Control
    wl-clipboard # Wayland clipboard utilities
    
    # Applications
    discord
    firefox

    # Hyprland/Sway ecosystem
    grim # Screenshot utility for Wayland
    mako # Notification daemon for Wayland
    slurp # Region selection for Wayland (used with grim)
    swaybg # Wallpaper utility (or hyprpaper)
    swaylock-effects # Screen locker with effects
    waybar # Status bar for Wayland compositors
    wofi # Application launcher / menu for Wayland
  ];

  # Basic git configuration (example)
  programs.git = {
    enable = true;
    userName = "Raj Kumar Vyas";
    userEmail = "inbox@rajvyas.com"; # Change this
  };

  # Kitty terminal configuration (example, we'll refine this)
  programs.kitty = {
    enable = true;
    # We can link to an existing kitty.conf or define settings here.
    # For now, just enabling it.
  };

  # Add more Home Manager modules for your applications here.
  # For example, for Hyprland related tools if not managed system-wide.
  # programs.waybar.enable = true; # etc.

  # Dotfile management will be added here.
  # For example:
  # home.file.".config/hypr/hyprland.conf".source = ../dotfiles/hyprland.conf;
  # home.xdg.configFile."kitty/kitty.conf".source = ../dotfiles/kitty.conf;
  # home.xdg.configFile."hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;
  # home.xdg.configFile."kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
  # home.xdg.configFile."neofetch/config.conf".source = ./dotfiles/neofetch/config.conf;
  # Session variables can also be set here if they are user-specific
  # environment.sessionVariables = {
  #   EDITOR = "nvim";
  # };
}
