{ config, pkgs, ... }:
let
  dotfiles = "/home/jacob/NixOS/cfgs";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
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
	    gh            # GitHub CLI
	    nix-search    # Package repo search
	    pfetch        # System info
	    sutils        # Battery & Clock commands
	    weather       # Forecast

	    ## NVIM CLI
	    fd            # Better find
	    ripgrep       # Better grep
	    nodejs	  # for treesitter parsers

	    ## NVIM lang servers
	    nil		  # LSP for nix lang
	    nixpkgs-fmt	  # "
	];

	programs.neovim = {
		enable = true;
		defaultEditor = true;
		withPython3 = true;
		withRuby = true;
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
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;
}
