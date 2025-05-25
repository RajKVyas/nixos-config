# /etc/nixos/users.nix
# User account definitions and user-specific packages.
{ config, pkgs, lib, ... }:

{
  users.users.raj = {
    isNormalUser = true;
    description = "R";
    extraGroups = [ "networkmanager" "wheel" "audio" ]; # Common groups for admin, network, audio
    packages = with pkgs; [
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
  };
}
