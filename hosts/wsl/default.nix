{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../../desktop.nix
  ];

  # Set hostname for WSL
  networking.hostName = "wsl";

  # Proper user configuration for WSL

  wsl = {
    enable = true;
    defaultUser = "raj";
    startMenuLaunchers = true;
    wslConf = {
      user = {
        default = "raj";
      };
    };
  };

  # Disable systemd-boot since WSL uses Windows bootloader
  boot.loader.systemd-boot.enable = false;

  # Disable display manager (ly) since we'll start Hyprland manually
  services.displayManager.ly.enable = false;


  # Disable systemd-timesyncd (handled by Windows host)
  services.timesyncd.enable = false;

  # System packages (removed GNOME-specific packages)
  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
