# NixOS Configuration

## Quick Setup

1. Download and extract configuration:
```bash
sudo sh -c 'curl -L https://github.com/RajKVyas/nixos-config/tarball/main | tar xz --strip-components=1 -C /etc/nixos'
cd /etc/nixos
```

2. For private repos, add authentication to the URL:
```bash
# Using HTTPS with token (replace <TOKEN> with your token):
sudo sh -c 'curl -L https://<TOKEN>@github.com/RajKVyas/nixos-config/tarball/main | tar xz --strip-components=1 -C /etc/nixos'
cd /etc/nixos
```

3. Apply configuration:
```bash
sudo nixos-rebuild switch --flake .#r-pc
```

## Customization
- Replace `r-pc` with your hostname in the rebuild command
- Edit `hosts/r-pc/default.nix` for system-specific settings
- Edit `home/raj/home.nix` for user-specific settings
