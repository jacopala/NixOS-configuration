### IMPORTANT MANAGEMENT COMMANDS
### written by yours truly
### ...in case autocomplete is a butt
## Update NixOS configuration
sudo nixos-rebuild switch --flake ~/NixOS#nixos-btw --show-trace
# switch: apply and make new boot
## created "rb-switch" script to shorten process
# test: apply without saving
# boot: save without applying

## Alternatively...
home-manager switch
# can be used to update only with home.nix

## List configuration generations
nixos-rebuild list-generations

## Delete unused store paths
nix-collect-garbage
# '-d' deletes old profiles
# '--delete-older-than 30d'

## Delete older generations
nix-env --delete-generations +5
# Keeps current and 4 more

## Link identical files in store
nix-store --optimise
# saves space for free

### FLAKES
## Update flake inputs
sudo nix flake update
# e.g. nixpkgs and home-manager

## See flake outputs
nix flake show

## Check flake syntax
nix flake check

### If receiving "Git tree __ is dirty" ... update the local git repo using:
git add .
git commit -m "message"
# If not branching and flowing, one mainline is enough
