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
  
  programs.zsh.enable = true;
  programs.steam.enable = true;
}
