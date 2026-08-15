{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/NixOS/cfgs";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  # Link config files in ./cfgs
  configs = {
    sway = "sway";
    alacritty = "alacritty";
    nvim = "nvim";
    wofi = "wofi";
  };
in
{
  # User specific packages
	home.packages = with pkgs; [
    ## Applications
    alacritty       # Terminal 
    cheese          # Camera
    fuzzel          # Launcher
    obsidian        # Knowledge base
    quickshell      # Widget toolkit
    swaybg          # Wallpaper
    wofi            # Menu
    yazi            # File Manager

    ## CLI
    btop          # Resource monitor
    nix-search    # Package repo search
    pfetch        # System info
    sutils        # Battery & Clock commands
    weather       # Forecast

    ## NVIM Editor (tony's setup)
		neovim
		ripgrep		    # for telescope
		nil		        # LSP for nix lang
		nixpkgs-fmt	  # "
		nodejs		    # for treesitter parsers
	];

  # Additional init
	home.username = "jacob";
	home.homeDirectory = "/home/jacob";
	programs.git.enable = true;
	home.stateVersion = "25.05";
	programs.bash = {
		enable = true;
    initExtra = ''
      export PS1="[ \\[\\e[38;5;4m\\]\w\\[\\e[0m\\] ]\\n\\[\\e[0m\\]\\$ "
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
