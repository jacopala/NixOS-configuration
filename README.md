### IMPORTANT COMMANDS

# Update NixOS configuration
sudo nixos-rebuild switch --flake ~/NixOS#nixos-btw --show-trace
# switch: apply and make new boot
# test: apply without saving
# boot: save without applying

# Delete unused store paths
nix-collect-garbage

# Delete older configurations
nix-collect-garbage -d
...or
nix-collect-garbage --delete-older-than 30d

# Links identical files in store
nix-store --optimise
