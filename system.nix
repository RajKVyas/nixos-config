
# /etc/nixos/system.nix
# Core system configurations.
{ config, pkgs, lib, ... }:

{
  # --- System Boot ---
  # Bootloader configuration moved to host-specific files
  boot.tmp.cleanOnBoot = true;

  # --- Networking ---
  networking.hostName = lib.mkDefault "r-pc"; # Define your hostname (can be overridden by host-specific configs)
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
  services.openssh.enable = true; # Enable SSH daemon
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
    Port = 3232;
    AllowTcpForwarding = "no";
    X11Forwarding = false;
    AllowAgentForwarding = false;
    AllowStreamLocalForwarding = false;
    AuthenticationMethods = "publickey";
  };

  
  # Automatic system upgrades
system.autoUpgrade = {
  enable = true;
  flake = "path:/etc/nixos";
  flags = [ "--recreate-boot-entries" ];
  dates = "03:00";
};
  
  # Security hardening (basic)
  security.sudo.execWheelOnly = true;

  # Enable Zsh system-wide
  programs.zsh = {
    enable = true;
    # Enable autocompletion and other useful features
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Example of other program configurations (can be moved to specific modules if large)
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Environment variables for Wayland applications
  environment.sessionVariables = {
    # Force Qt applications to use Wayland
    QT_QPA_PLATFORM = "wayland";
    # Force GTK applications to use Wayland
    GDK_BACKEND = "wayland";
    # Force SDL applications to use Wayland
    SDL_VIDEODRIVER = "wayland";
    # Force Clutter applications to use Wayland
    CLUTTER_BACKEND = "wayland";
    # Set XDG environment variables
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    # Enable Wayland for Electron applications
    NIXOS_OZONE_WL = "1";
  };
}
