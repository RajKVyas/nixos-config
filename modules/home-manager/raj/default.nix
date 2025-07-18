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
    extraConfig.init.defaultBranch = "main";
  };

  systemd.user.services.vesktop = {
    Unit = {
      Description = "Start Vesktop on login";
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
    
      RemainAfterExit = true;
    
      ExecStart = "${pkgs.vesktop}/bin/vesktop";
    };
  };

}
