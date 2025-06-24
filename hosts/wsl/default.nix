{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  # Set hostname for WSL
  networking.hostName = "wsl";

  # Proper user configuration for WSL
  users.users.raj = {
    isNormalUser = true;
    description = "Raj Kumar Vyas";
    extraGroups = ["wheel" "networkmanager" "video" "audio"];
    home = "/home/raj";
    createHome = true;
    useDefaultShell = true;
  };

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

  # Enable GUI desktop environment
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xkb.layout = "us";
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "raj";
  };

  # Enable audio support
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Disable systemd-timesyncd (handled by Windows host)
  services.timesyncd.enable = false;

  # System packages
  environment.systemPackages = with pkgs; [
    git
    gnome-terminal
    firefox
    vim
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
