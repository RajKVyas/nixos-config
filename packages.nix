# /etc/nixos/packages.nix
# System-wide packages available to all users.
{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # System utilities
    btop # Resource monitor
    curl
    git
    htop # Interactive process viewer
    p7zip # For 7zip archives
    unzip
    wget
    comma

    # Basic editor (Nano is often included by default)
    # vim # Or your preferred editor like neovim, emacs, etc.
    # Do not forget to add an editor to edit configuration.nix!
  ];
  
  # Add comprehensive set of Nerd Fonts for proper icon display
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.noto
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.roboto-mono
    nerd-fonts.iosevka
    nerd-fonts.inconsolata
    nerd-fonts.inconsolata-go
    nerd-fonts.inconsolata-lgc
    nerd-fonts.mononoki
    nerd-fonts.monoid
    nerd-fonts.symbols-only
  ];
}
