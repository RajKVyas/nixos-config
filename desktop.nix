# /etc/nixos/desktop.nix
# Desktop environment, audio, fonts, and related settings.
{ config, pkgs, lib, ... }:

{
  # --- Audio ---
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; # For PulseAudio compatibility
    jack.enable = true;  # For JACK compatibility
  };

  # --- Flatpak support with nix-flatpak ---
  services.flatpak = {
    enable = true;
    remotes = [
      { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
    ];
    packages = [
      { appId = "org.nickvision.tubeconverter"; origin = "flathub"; }
    ];
  };

  # --- Fonts ---
  fonts.packages = with pkgs; [
    dejavu_fonts
    fira-code
    fira-code-symbols
    liberation_ttf
    mplus-outline-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    # Nerd Fonts for icon support (only keep essential fonts)
    nerd-fonts.jetbrains-mono  # Used by Kitty terminal and Starship
    nerd-fonts.symbols-only    # Provides essential icons
  ];
  fonts.fontconfig.enable = true; # Enable Fontconfig for font customization

  # --- Graphical Environment ---
  # Display Manager
  services.displayManager.ly.enable = true;

  # Window Manager (Hyprland)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # For X11 compatibility in Wayland
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk # Or -kde if you prefer Qt apps primarily
    ];
    # Optional: You can explicitly set Hyprland as a default for some interfaces
    configPackages = [ pkgs.hyprland ]; # Might be needed depending on specific portal interactions
  };

  # Session variables for Wayland applications

  # X11 Keyboard configuration (also used by XWayland)
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Gaming optimization
  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Optional: for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Optional
  };
}
