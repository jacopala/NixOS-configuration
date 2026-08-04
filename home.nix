{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos/cfgs";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    qtile = "qtile";
    nvim = "nvim";
    alacritty = "alacritty";
    rofi = "rofi";
  };
in
{
	home.username = "jacob";
	home.homeDirectory = "/home/jacob";
	programs.git.enable = true;
	home.stateVersion = "25.05";
	programs.bash = {
		enable = true;
    initExtra = ''
      export PS1="[ \\[\\e[38;5;4m\\]\w\\[\\e[0m\\] ]\\n\\[\\e[0m\\$ "
    '';
	};

  xdg.configFile = builtins.mapAttrs 
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

	home.packages = with pkgs; [
		neovim
		ripgrep		# for nvim telescope
		nil		# LSP for nix lang
		nixpkgs-fmt	# "
		nodejs		# for installing treesitter parsers
		gcc		# for compiling treesitter parsers
    rofi
	];
}
