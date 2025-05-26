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

  # --- Fonts ---
  fonts.packages = with pkgs; [
    dejavu_fonts
    fira-code
    fira-code-symbols
    liberation_ttf
    mplus-outline-fonts.githubRelease # Corrected attribute if it was a typo for .mplus-outline-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
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
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Advise Electron/Chromium apps to use Wayland

  # X11 Keyboard configuration (also used by XWayland)
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
