# /etc/nixos/packages.nix
# System-wide packages available to all users.
{ config, pkgs, lib, ... }:

{
environment.systemPackages = with pkgs; [
  # System utilities
  btop # Resource monitor
  curl
  htop # Interactive process viewer
  p7zip # For 7zip archives
  unzip
  wget
  comma
  nano
  nvim
  lynis # Security auditing tool
  clamav # Antivirus scanner

    # Basic editor (Nano is often included by default)
    # vim # Or your preferred editor like neovim, emacs, etc.
    # Do not forget to add an editor to edit configuration.nix!
  ];
  

}
