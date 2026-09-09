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

# Touchpad
   services.libinput.enable = true;

# Browser
   programs.firefox.enable = true;

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
         brightnessctl     # Brightness
         pulseaudio        # Audio
         sox		# Audio utility
         wl-clipboard      # Clipboard ext.

         auto-cpufreq      ## CPU/power optimizer

         gcc               ## C-lang compiler
         git            ## Github + version control
         pkg-config     ## Packages can find information about other packages
         unzip          ## Decompressor
         wget           ## Network downloader
         vim            ## Text editor
   ];

# Fonts
   fonts.fontDir.enable = true;
   fonts.packages = with pkgs; [
      nerd-fonts.departure-mono # pixelated, techy font
         nerd-fonts.envy-code-r    # compact, rounded font
         nerd-fonts.hurmit         # bulkier, modernistic font
         nerd-fonts.intone-mono    # legible, standard font
         nerd-fonts.symbols-only   # fallback symbol font for others
   ];

# Allowed unfree/licensed packages
   nixpkgs.config.allowUnfreePackages = [
      "obsidian"
   ];

### SYSTEM SETTINGS
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
         wifi.scanRandMacAddress = false;
      };
   };
   time.timeZone = "America/Chicago";

   users.users.jacob = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
   };

   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   system.stateVersion = "26.05";
}
