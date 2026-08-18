# Resources:
# configuration.nix(5) man page
# https://search.nixos.org/options
# nixos-help
{ config, lib, pkgs, ... }:

{
  ### WINDOW MANAGER / DISPLAY ENVIRONMENT

  # Ly Login
  services.displayManager.ly.enable = true;
  
  # Sway
  services.gnome.gnome-software.enable = true;
  programs.sway = {
    enable = true;
    xwayland.enable = true;
    extraPackages = with pkgs; [
      brightnessctl   # Brightness
      pulseaudio      # Audio
      wl-clipboard    # Clipboard ext.
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

  ### SYSTEM PACKAGES

  # System packages
  environment.systemPackages = with pkgs; [
  	gcc
	git
	unzip
	wget
    	vim
  ];

  # Fonts
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
  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";

  users.users.jacob = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";
}
