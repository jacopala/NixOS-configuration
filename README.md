### IMPORTANT MANAGEMENT COMMANDS

## Update NixOS configuration
sudo nixos-rebuild switch --flake ~/NixOS#nixos-btw --show-trace
# switch: apply and make new boot
# test: apply without saving
# boot: save without applying

## Delete unused store paths
nix-collect-garbage
# '-d' deletes old profiles
# '--delete-older-than 30d'

## Link identical files in store
nix-store --optimise
# saves space for free

## Update flake inputs
sudo nix flake update
# e.g. nixpkgs and home-manager

## See output schema
nix flake show

## Check flake syntax
nix flake check

### If receiving "Git tree __ is dirty" ... update the local git repo using:
git add .
git commit -m "message"
# If not branching and flowing, one mainline is enough
