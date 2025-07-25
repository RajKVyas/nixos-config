{ pkgs, config, ... }:

{
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;
    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = true;

    prime = {
      offload.enable = true;

      amdgpuBusId = "PCI:11:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
