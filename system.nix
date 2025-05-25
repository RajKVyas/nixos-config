
# /etc/nixos/system.nix
# Core system configurations.
{ config, pkgs, lib, ... }:

{
  # --- System Boot ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  # --- Networking ---
  networking.hostName = "r-pc"; # Define your hostname
  networking.networkmanager.enable = true; # Use NetworkManager for network configuration

  # Optional: Wireless support (if not using NetworkManager for this)
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Optional: Network proxy configuration
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Firewall
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ]; # Example: [ 80 443 ]
  # networking.firewall.allowedUDPPorts = [ ... ];

  # --- Localization & Time ---
  time.timeZone = "America/New_York"; # Set your time zone

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us"; # Keymap for TTY console
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # --- Nix Package Manager Settings ---
  nixpkgs.config.allowUnfree = true; # Allow installation of unfree packages

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  nix.gc = { # Garbage collection settings
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.max-jobs = lib.mkDefault 4; # Adjust to number of CPU cores for faster builds

  # --- Core System Services ---
  services.ntp.enable = true; # Network Time Protocol for time synchronization
  # services.openssh.enable = true; # Enable SSH daemon if needed

  # Example of other program configurations (can be moved to specific modules if large)
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
