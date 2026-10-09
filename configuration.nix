# Resources:
# configuration.nix(5) man page
# https://search.nixos.org/options
# nixos-help
{ config, lib, pkgs, ... }:

{
### WINDOW MANAGER / DISPLAY ENVIRONMENT

# Ly greeter
   services.displayManager.ly.enable = true;

# X11 -> Wayland Compat
   programs.xwayland.enable = true;
   #services.gnome.gnome-software.enable = true;

# Compositors/Window Managers
   programs.sway.enable = true;
   programs.niri.enable = true;

# Cron Jobs
   services.cron = {
      enable = true;
      systemCronJobs = [
         # Cleanup
         "0 0 */3 * *   root  \
         nix-env --delete-generations +3 ; \
         nix-store --optimise > /home/jacob/.cronlog"
         # Github backup
         ''
         0 0 */3 * *  jacob  \
         cd /home/jacob/NixOS/ && \
         GIT_SSH_COMMAND="/run/current-system/sw/bin/ssh -i /home/jacob/.ssh/id_ed25519.pub" \
         /run/current-system/sw/bin/git push origin main>> /home/jacob/.cronlog
         ''
      ];
   };

# Pipewire audio
   services.pipewire = {
      enable = true;
      pulse.enable = true;
   };

# VirtualBox
   virtualisation.virtualbox.host = {
      enable = true;
      headless = false;
   };

# Touchpad
   services.libinput.enable = true;

# CUPS Printing
   services.printing.enable = true;

# Browser
   programs.firefox.enable = true;

# Steam
   programs.steam.enable = true;

# Tailscale
   services.tailscale.enable = true;

# Bluetooth
   hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
   };

### SYSTEM PACKAGES

# System packages
   environment.systemPackages = with pkgs; [
         google-chrome     # LDB prereq

         brightnessctl     # Brightness
         ibus              # Input Bus
         #pulseaudio        # Audio
         sox		         # Audio utility
         wl-clipboard      # Clipboard ext.
         xwayland-satellite

         auto-cpufreq      ## CPU/power optimizer

         file              ## File details (idk why this isnt default)
         gcc               ## C-lang compiler
         git            ## Github + version control
         pkg-config     ## Packages can find information about other packages
         unzip          ## Decompressor
         wget           ## Network downloader
         vim            ## Text editor
   ];

   services.mysql = {
      enable = true;
      package = pkgs.mysql84;
   };
   services.mysqlBackup.enable = true;

# Fonts
   fonts.fontDir.enable = true;
   fonts.packages = with pkgs.nerd-fonts; [
      intone-mono

      hurmit
      fantasque-sans-mono
      lilex
      monaspace

      symbols-only   # fallback symbol font for others
   ];

# Allowed unfree/licensed packages
   nixpkgs.config.allowUnfreePackages = [
      "google-chrome"
      "obsidian"
      "osu-lazer-bin"
      "steam"
      "steam-unwrapped"
      "vscode"
   ];

### SHELL
   users.defaultUserShell = pkgs.fish;
   environment.shellAliases = {
      b = "battery";
      kali = "VBoxManage startvm Kali --type sdl";
      ls = "eza --icons";
      n = "nvim";
      p = "ping google.com -c 1";
      y = "yazi";
   };
   programs = {
      bash.enable = true;
      fish = {
         enable = true;
         shellInit = ''
            fish_config prompt choose nim
         '';
      };
   };

### SYSTEM
   users.users.jacob = {
      isNormalUser = true;
      extraGroups = [ "wheel" "vboxusers" ];
      shell = pkgs.fish;
   };

   imports =
      [
      ./hardware-configuration.nix
      ];
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;
   networking = {
      hostName = "nixos-btw";
      networkmanager = {
         enable = true;
         wifi = {
            #backend = "iwd";
            powersave = false;
            scanRandMacAddress = false;
         };
      };
   };
   time.timeZone = "America/Chicago";

   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   system.stateVersion = "26.05";
}
