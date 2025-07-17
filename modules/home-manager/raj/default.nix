{ pkgs, ... }:

{
  imports = [
    ../core.nix
  ];

  home.packages = with pkgs; [
    vlc
    vesktop
    btop
    fastfetch
    kitty
  ];

  programs.git = {
    enable = true;
    userName = "Raj Kumar Vyas";
    userEmail = "inbox@rajvyas.com";
    configExtra = { init.defaultBranch = main }
  };

  systemd.user.services.vesktop = {
    Unit = {
      Description = "Start Vesktop Discord client";
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.vesktop}/bin/vesktop";
    };
  };


}
