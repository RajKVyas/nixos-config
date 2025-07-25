{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    git
    wget
    htop
    unzip
    p7zip
    tree
    winetricks
    wineWow64Packages.stagingFull
  ];

  programs.steam.enable = true;
}
