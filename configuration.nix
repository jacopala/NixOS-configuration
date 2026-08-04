# Resources:
# configuration.nix(5) man page
# https://search.nixos.org/options
# nixos-help
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  # X11 + QTile
  #services.xserver = {
  #  enable = true;
  #  autoRepeatDelay = 100;
  #  autoRepeatInterval = 30;
  #  windowManager.qtile.enable = true;
  #};
  #services.displayManager.ly.enable = true;

  # Sway Window Manager
  services.sway = {
    enable = true;
    extraPackages = with pkgs; [
      ## APPLICATIONS
      alacritty       # Terminal 
      wofi            # Menu
      swaybg          # Wallpaper
      greetd.wlgreet  # Greeter
      qs              # Widget toolkit
      dunst           # Notifications
      swaylock        # Lockscreen
      ## SYSTEM
      brightnessctl   # Brightness
      pulseaudio      # Audio
      wl-clipboard    # Copy/Paste ext.
    ];
  };
  # Wayland + X11 compatability
  programs.xwayland.enable = true;

  # Pipewire audio
  #services.pipewire = {
  #  enable = true;
  #  pulse.enable = true;
  #};

  # Touchpad support (default for most desktopManagers)
  #services.libinput.enable = true;

  users.users.jacob = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    # Less essential packages
    packages = with pkgs; [
      eza
    ];
  };

  programs.firefox.enable = true;

  # Essential packages
  # Minimal # of packages for all users to share
  environment.systemPackages = with pkgs; [
    gcc
    vim
    wget
    git
    alacritty
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono # pixelated, techy font
    nerd-fonts.envy-code-r    # compact, rounded font
    nerd-fonts.hurmit         # bulkier, modernistic font
    nerd-fonts.intone-mono    # legible, standard font
    nerd-fonts.symbols-only   # fallback symbol font for others
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
