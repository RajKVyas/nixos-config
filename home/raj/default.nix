# /etc/nixos/home/raj/home.nix
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
    vesktop
    firefox
    # JetBrains Mono Nerd Font
    nerd-fonts.jetbrains-mono

    # Add fzf for the edit-config function
    fzf

    # --- ADDED: New System & Resource Monitors ---
    bottom # TUI resource monitor, like htop/btop
    fastfetch # A faster alternative to neofetch
    mission-center # GUI resource monitor

    # --- ADDED: New GUI Applications ---
    easyeffects # Audio effects for PipeWire
    upscaler # Image upscaling application

    # Hyprland/Sway ecosystem
    grim # Screenshot utility for Wayland
    mako # Notification daemon for Wayland
    slurp # Region selection for Wayland (used with grim)
    hyprpaper # Wallpaper utility
    swaylock-effects # Screen locker with effects
    waybar # Status bar for Wayland compositors
    rofi-wayland # Application launcher (replaces wofi)
    # wofi # Application launcher / menu for Wayland
    playerctl
    xdg-utils
    networkmanagerapplet
    bibata-cursors #capitaine-cursors
    kdePackages.dolphin
    jq
    nh
  ];

  # Basic git configuration (example)
  programs.git = {
    enable = true;
    userName = "Raj Kumar Vyas";
    userEmail = "inbox@rajvyas.com"; # Change this
  };

  # Kitty terminal configuration
  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font"; # Updated for Starship compatibility
    font.size = 12;
    settings = {
      background_opacity = "0.85";
      # Add other settings from kitty.conf here
    };
  };

  # Zsh configuration with nh/nix aliases
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    antidote.enable = true; # Zsh plugin manager
    antidote.plugins = with pkgs; [
      "zsh-users/zsh-autosuggestions"
      "zsh-users/zsh-completions"
      "zsh-users/zsh-history-substring-search"
    ];
    syntaxHighlighting.enable = true;
    shellAliases = {
      ns = "nh os switch --flake /etc/nixos#$(hostname)";
      nsu = "cd /etc/nixos && nix flake update && nh os switch --flake .#$(hostname)";
      nc = "nh clean -k 7d -K 5";
      nfu = "nix flake update /etc/nixos";
      run-chroot = "steam-run";
    };
    initContent = ''
      # FZF-based config editing
      edit-config() {
        local file
        file=$(find /etc/nixos -type f -name "*.nix" | fzf --height 40% --layout=reverse --border)
        [ -n "$file" ] && ${pkgs.nano}/bin/nano "$file"
      }
      bindkey -s '^e' 'edit-config\n'
    '';
  };

  # Starship prompt configuration with Jetpack preset
  # Starship prompt configuration
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Import settings from the TOML file instead of defining them inline
    settings = lib.importTOML ./dotfiles/starship.toml;
  };

  # Wayland utilities
  programs.waybar.enable = true;

  # Shell workflow improvements
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.nix-index.enable = true;

  # Add more Home Manager modules for your applications here.
  # For example, for Hyprland related tools if not managed system-wide.

  # Dotfile management for Hyprland
  xdg.configFile."hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf; # FIXED: Added missing semicolon

  # Neofetch configuration (temporarily disabled to resolve build error)
  # programs.neofetch = {
  #   enable = true;
  #   settings = {
  #     print_info = ''
  #       info title
  #       info underline
  #       info "OS" distro
  #       info "Host" model
  #       info "Kernel" kernel
  #       info "Uptime" uptime
  #       info "Packages" packages
  #       info "Shell" shell
  #       info "Resolution" resolution
  #       info "DE" de
  #       info "WM" wm
  #       info "Theme" theme
  #       info "Icons" icons
  #       info "Terminal" term
  #       info "Terminal Font" term_font
  #       info "CPU" cpu
  #       info "GPU" gpu
  #       info "Memory" memory
  #       info cols
  #     '';
  #     image_backend = "ascii";
  #     ascii_distro = "NixOS_small";
  #     # Add other settings from config.conf here
  #   };
  # };

  # Wallpaper configuration using Nix store path
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${./dotfiles/hypr/linux-nixos-7q-3840x2400.jpg}
    wallpaper = ,${./dotfiles/hypr/linux-nixos-7q-3840x2400.jpg}

    # For multiple monitors, e.g.:
    # wallpaper = DP-1,/path/to/wallpaper-for-DP-1.png
    # wallpaper = HDMI-A-1,/path/to/wallpaper-for-HDMI-A-1.png

    # To have a fallback if a monitor isn't found
    # wallpaper = ,fallback_wallpaper.png

    ipc = off # Or on, if you want to control it via hyprctl
  '';

  # Session variables can also be set here if they are user-specific
  # environment.sessionVariables = {
  #   EDITOR = "nvim";
  # };
}
