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
  ];
}
