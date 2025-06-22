# NVIDIA-specific configuration
{ config, lib, pkgs, ... }:

{
  # --- Graphics Configuration (NVIDIA) ---
  # Enable general graphics support (Mesa, etc.)
  hardware.graphics.enable = true;

  # Enable 32-bit OpenGL support (for games, Wine, Steam)
  hardware.graphics.enable32Bit = true;

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

    # Specify the NVIDIA driver package. Use stable for production systems
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
