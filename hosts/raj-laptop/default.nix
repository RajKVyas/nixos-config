{ config, pkgs, inputs, ... }:

{
  imports = [
    # This file will be generated during installation
    ./hardware.nix

    # Common modules shared with your PC
    ../../modules/nixos/core.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/gnome.nix
  ];

  # Bootloader Configuration for the Laptop (GRUB)
  # This uses the small EFI partition just for the bootloader, keeping kernels on the root partition.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver # For hardware video acceleration
  ];
  
  networking.hostName = "raj-laptop";

  zramSwap.enable = true;

  swapDevices = [{
    device = "/swapfile";
    size = 4 * 1024; # 4GB
  }];

  users.users.raj = {
    isNormalUser = true;
    description = "Raj Kumar Vyas";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "users" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      raj = import ../../modules/home-manager/raj;
    };
  };
  
  system.stateVersion = "25.05";
}
