{ pkgs, ... }:

{
  imports = [
    ../core.nix
  ];

  home.packages = with pkgs; [
    vlc
    vesktop
    steam
    btop
    fastfetch
    kitty
    vscode
    gimp
    qbittorrent
    clamav

    # ==> SDR Software <==
    gqrx          # General purpose graphical SDR receiver
    sdrpp   # A modern, popular alternative to Gqrx
    #dsd
    #dsd-fme       # Command-line digital speech decoder (DMR, P25, etc.)
    #gpredict      # For tracking satellites, not working
  ];


  programs.git = {
    enable = true;
    userName = "Raj Kumar Vyas";
    userEmail = "inbox@rajvyas.com";
    extraConfig.init.defaultBranch = "main";
  };


}
