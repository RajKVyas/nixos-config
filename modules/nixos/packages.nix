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

  fonts.enableDefaultPackages = true;
  fonts.fontconfig.defaultFonts.monospace = ["FiraCode Nerd Font Mono 11"];
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
  
  programs.zsh.enable = true;
  programs.steam.enable = true;
}
