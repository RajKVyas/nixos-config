{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;



  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.advanced-alttab-window-switcher

    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.user-themes
    gnomeExtensions.appindicator
    gnomeExtensions.pano
    gnomeExtensions.gsconnect
    gnomeExtensions.vitals
    gnomeExtensions.caffeine
  ];

  services.printing.enable = true;
}
