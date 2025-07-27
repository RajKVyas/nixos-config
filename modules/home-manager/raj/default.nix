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
    bat
    gqrx
    sdrpp
    tmux
    duf
    zoxide
    fzf
    tldr
    bitwarden
    prismlauncher    
    wl-clipboard
    spot
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };


  programs.git = {
    enable = true;
    userName = "Raj Kumar Vyas";
    userEmail = "inbox@rajvyas.com";
    extraConfig.init.defaultBranch = "main";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    
    history = {
      size = 10000;
      share = true; # Share history across all sessions
      ignoreDups = true;
    };
    
    shellAliases = {
      # NixOS Management
      nrs = "sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)";
      nfu = "sudo nix flake update";
      cdn = "cd /etc/nixos";

      # Git Actions
      gaa = "git add .";
      gc = "git commit -m";
      gp = "git push";
      gpo = "git push origin"; # Push to origin
      gpg = "git push gitlab"; # Push to gitlab
      gpa = "git push origin && git push gitlab"; # Push to all remotes

      # General Utilities
      l = "ls -lah";
      ll = "ls -l";
      ls = "ls --color=auto";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      # Use a Nerd Font in your terminal.
      format = "$all";

      # --- Add custom symbols for a productive prompt ---
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vimcmd_symbol = "[V](bold green)";
      };

      directory.read_only = " 󰌾";

      git_branch.symbol = " ";

      git_status = {
        stashed = " ";
        ahead = "󰜷 ";
        behind = "󰜮 ";
        diverged = "󰦓 ";
        untracked = " ";
        staged = "[++\\($count\\)](green) ";
        modified = "[! \\($count\\) '\\(ᗒᗣᗕ\\)՞](yellow) ";
        renamed = "[» \\($count\\)](green) ";
        deleted = "[--\\($count\\)](red) ";
      };

      nix_shell.symbol = " ";
    };
  };
}
