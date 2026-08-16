#{ config, pkgs, ... }:
{ pkgs, ... }:
let
  #dotfiles = "${config.home.homeDirectory}/NixOS/cfgs";
  #create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  # Link config files in ./cfgs
  configs = {
    alacritty = "alacritty";
    fuzzel = "fuzzel";
    nvim = "nvim";
    quickshell = "quickshell";
    sway = "sway";
    swaylock = "swaylock";
    wofi = "wofi";
    yazi = "yazi";
  };
in
{
  # User specific packages
	home.packages = with pkgs; [
    ## Applications
    alacritty       # Terminal 
    cheese          # Camera
    obsidian        # Notes
    quickshell      # Widgets
    swaybg          # Wallpaper
    swaylock        # Sceen locker
    vlc             # Media player
    wofi            # Menu
    yazi            # File Manager

    ## CLI
    htop          # Resource monitor
    eza           # Better ls
    fd            # Better find
		ripgrep		    # Better grep
    gh            # GitHub CLI
    nix-search    # Package repo search
    pfetch        # System info
    sutils        # Battery & Clock commands
    weather       # Forecast

		#neovim
	];

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      nil		        # LSP for nix lang
      nixpkgs-fmt	  # "
      nodejs		    # for treesitter parsers
    ];
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      obsidian-nvim
    ];
  };

  # Additional init
	home.username = "jacob";
	home.homeDirectory = "/home/jacob";
	programs.git.enable = true;
	home.stateVersion = "25.05";
	programs.bash = {
		enable = true;
    initExtra = ''
      export PS1="\[\e[38;5;4m\]✦ \w\[\e[3m\]\n✨\[\e[0m\]"
      alias yz="yazi"
      alias ls="eza --icons"
      export PATH="$HOME/NixOS/scripts/:$PATH"     
    '';
	};
  
  # Function to assign config files
  xdg.configFile = builtins.mapAttrs 
    (name: subpath: {
      #source = create_symlink "${dotfiles}/${subpath}";
      source = ./cfgs + "/${subpath}";
      recursive = true;
    })
    configs;
}
