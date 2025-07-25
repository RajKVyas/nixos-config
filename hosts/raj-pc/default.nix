{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix

    ../../modules/nixos/core.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/nvidia-raj-pc.nix
    ../../modules/nixos/gnome.nix
    # We will add more here later, like hyprland.nix, nvidia.nix, etc.
  ];

  fileSystems = {
    "/mnt/projects" = {
      device = "/dev/disk/by-uuid/5AB84472B8444F27";
      fsType = "ntfs";
      options = [ "rw" "uid=1000" "gid=100" "nofail" ];
    };

    "/mnt/media" = {
      device = "/dev/disk/by-uuid/78AC445CAC4416D2";
      fsType = "ntfs";
      options = [ "rw" "uid=1000" "gid=100" "nofail" ];
    };

    "/mnt/backup" = {
      device = "/dev/disk/by-uuid/763C181F3C17D947";
      fsType = "ntfs";
      options = [ "rw" "uid=1000" "gid=100" "nofail" ];
    };
    
    "/mnt/data" = {
      device = "/dev/disk/by-uuid/FE4A4B8A4A4B3EA1";
      fsType = "ntfs";
      options = [ "rw" "uid=1000" "gid=100" "nofail" ];
    };

    "/mnt/main" = {
      device = "/dev/disk/by-uuid/568C8DA38C8D7DED";
      fsType = "ntfs";
      options = [ "rw" "uid=1000" "gid=100" "nofail" ];
    };
    "/mnt/windows" = {
      device = "/dev/disk/by-uuid/686832096831D712";
      fsType = "ntfs";
      options = [ "rw" "uid=1000" "gid=100" "nofail" ];
    };
  };

  hardware.rtl-sdr.enable = true;
  services.udev.packages = [ pkgs.rtl-sdr ];
  boot.blacklistedKernelModules = [ "dvb_usb_rtl28xxu" ];
  
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
  '';

  boot.binfmt.emulatedSystems = [
    "x86_64-windows"
    "i686-windows" # For 32-bit Windows executables
  ];

  virtualisation.docker.enable = true;

  users.users.raj = {
    isNormalUser = true;
    description = "Raj Kumar Vyas";
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
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

  networking.hostName = "raj-pc";
  system.stateVersion = "25.05";
}
