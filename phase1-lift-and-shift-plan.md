# Phase 1: Lift and Shift Plan

## 1. Update flake.nix
```diff
<<<<<<< SEARCH
commonModules = [
  ./configuration.nix
  inputs.home-manager.nixosModules.default
  { home-manager.users.raj = import ./home/raj/home.nix; }
  inputs.nix-flatpak.nixosModules.nix-flatpak
];
=======
commonModules = [
  ./hosts/common.nix
  inputs.home-manager.nixosModules.default
  { home-manager.users.raj = import ./home/raj/home.nix; }
  inputs.nix-flatpak.nixosModules.nix-flatpak
];
>>>>>>> REPLACE
```

## 2. Populate hosts/common.nix
```nix
{ config, pkgs, lib, ... }:
{
  # Universal settings
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # User account
  users.users.raj = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  # Home Manager integration
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
}
```

## 3. Configure hosts/r-pc/default.nix
```nix
{ config, pkgs, lib, systemType, ... }:
{
  imports = [
    ../../hardware-configuration.nix
    ../../system.nix
    ../../hardware.nix
  ];

  # Host-specific settings
  networking.hostName = "r-pc";
  system.stateVersion = "25.05";

  # Hardware-specific settings
  hardware.bluetooth.enable = true;
  
  # Conditionally enable NVIDIA
  services.xserver.videoDrivers = lib.mkIf (systemType == "nvidia") [ "nvidia" ];
}
```

## 4. Verification Steps
```bash
# Build configuration
nixos-rebuild build --flake .#r-pc

# Test critical functionality:
# - Network connectivity
# - User login (raj)
# - SSH access
# - Hardware features (NVIDIA, Bluetooth)

# Compare system closures
nix store diff-closures /run/current-system ./result
```

## Next Steps
1. Review this plan
2. Approve for implementation
3. Switch to Code mode for execution