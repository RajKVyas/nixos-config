# /etc/nixos/hardware.nix
# Specific hardware configurations (e.g., NVIDIA, Bluetooth).
{ config, pkgs, lib, ... }:

{
  # --- Bluetooth ---
  hardware.bluetooth.enable = true;

  # --- Graphics Configuration (NVIDIA) ---
  # Enable general graphics support (Mesa, etc.)
  hardware.graphics.enable = true;

  # Enable 32-bit OpenGL support (for games, Wine, Steam)
  hardware.opengl.driSupport32Bit = true;

  # Specify NVIDIA drivers for Xorg/Xwayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Use modesetting for better compatibility with Wayland and modern Xorg.
    modesetting.enable = true;

    # Power management can be tricky. Default is often fine.
    # Set to true for laptops or if you want the driver to manage power more aggressively.
    # powerManagement.enable = false; # Original value, consider 'true' for laptops
    # powerManagement.finegrained = false; # Usually paired with powerManagement.enable

    # Use open-source kernel modules. Set to false for proprietary modules if 'open' has issues.
    open = true;

    # Install the nvidia-settings utility.
    nvidiaSettings = true;

    # Specify the NVIDIA driver package. 'beta' for newer, potentially less stable drivers.
    # Other options include 'stable', 'production', 'legacy_xyx', etc.
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
