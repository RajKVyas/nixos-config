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

    # ==> SDR Software <==
    gqrx          # General purpose graphical SDR receiver
    sdrpp   # A modern, popular alternative to Gqrx
    sdrtrunk      # Excellent for P25/DMR digital voice & trunking
    dsd-fme       # Command-line digital speech decoder (DMR, P25, etc.)
    gpredict      # For tracking satellites
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
