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
    #yazi = "yazi";
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

	    ## CLI
	    ast-grep      # Syntax grep
      #home-manager  # Nix home.nix manager
	    htop          # Resource monitor
	    eza           # Better ls
      fzf           # Fuzzy find
	    gh            # GitHub CLI
      nix-diff      # Compare Nix derivations
	    nix-search    # Package repo search
	    pfetch        # System info
	    ripgrep       # Better grep
	    sutils        # Battery & Clock commands
	    weather       # Forecast

      ## LAZYGIT
      lazygit
      vimPlugins.lazygit-nvim

      ## LANGS
      cargo         # Rust builder
      go            # GoLang
      jdk           # Java
      julia         # Julia lang
      luarocks      # Lua package man
      php           # PHP lang (HTML embedded)
      phpPackages.composer
      #pipx          # Isolated Python envs
      python3       # Python3
      ruby          # Ruby Lang

      ## NeoVIM
      neovim 
	];

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    plugins = with pkgs.yaziPlugins; {
      inherit 
        git
        lazygit;
    };
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
