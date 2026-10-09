{ config, pkgs, ... }:
let
dotfiles = "/home/jacob/NixOS/cfgs";
create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
configs = {
# sp = subpath in ./cfgs
# r  = recursively define
#	use true if needs solid files
#	use false if self-managed
   fuzzel      = { sp = "fuzzel"; r = true; };
   kitty       = { sp = "kitty"; r = true; };
   niri        = { sp = "niri"; r = true; };
   nvim 	      = { sp = "nvim";	r = false; };
   quickshell 	= { sp = "quickshell";	r = true;  };
   sway 	      = { sp = "sway";	r = true;  };
   swaylock 	= { sp = "swaylock";	r = true;  };
   yazi 	      = { sp = "yazi";	r = false; };
};
in
{
# User specific packages
   home.packages = with pkgs; [
## Applications
      fuzzel          # Launcher
      kitty           # Terminal
      obsidian        # Notes
      osu-lazer-bin   # Osu game
      plover_5        # Stenography
      quickshell      # Widgets
      swaybg          # Wallpaper
      swaylock        # Sceen locker
      vesktop         # Discord alt client

## Media
      calibre         # EPUB reader
      cheese          # Camera
      thunar          # GUI file manager (backup)
      zathura         # PDF reader
      vlc             # Video/Audio player

## CLI
      ast-grep    # Syntax grep
      bluetui     # Bluetooth TUI
      dragon-drop # Drag files
      htop        # Memory/process monitor
      eza         # Better ls
      fzf         # Fuzzy find
      gh          # GitHub CLI
      leetgo      # LeetCode CLI
      nix-search  # Package repo search
      nerdfetch   # System info
      powertop    # Battery monitor
      ripgrep     # Better grep
      sutils      # Battery & Clock commands
      tree-sitter # Parser generator
      ueberzugpp  # Images in terminal
      weather     # Forecast
      zoxide      # Better cd

## SECURITY
      metasploit  # Exploit collection
      nmap        # Network discovery
      openvpn     # Tunneling
      wireshark   # Network protocol analyzer

## LAZYGIT
      lazygit

## LANGS
      cargo          # Rust builder
      go             # GoLang
      jdk            # Java
      julia          # Julia lang
      lua5_1         # Lua lang
      luarocks       # Lua package man
      php            # PHP lang (HTML embedded)
      phpPackages.composer
#pipx          # Isolated Python envs
      python3        # Python3
      pipenv         # Python dev workflow
      ruby           # Ruby lang
      rustc          # Rust lang
   ];

   programs.yazi = {
      enable = true;
      shellWrapperName = "y";
   };
   programs.neovim = {
      enable = true;
      defaultEditor = true;
      withPython3 = true;
      withRuby = true;
      sideloadInitLua = true;
   };
   services.awww = {
      enable = true;
      extraArgs = ["--no-cache"];
   };
   programs.fish.enable = true;

   # VSC
   programs.vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
         prettier.prettier-vscode
         ritwickdey.liveserver
         vscodevim.vim
         tomoki1207.pdf
         ms-python.python
         ms-python.debugpy
         batisteo.vscode-django
         #kevinrose.vsc-python-indent
      ];
   };

# Additional init
   home.username = "jacob";
   home.homeDirectory = "/home/jacob";
   programs.git.enable = true;
   home.stateVersion = "25.05";

# Function to assign config files
   xdg.configFile = builtins.mapAttrs 
      (name: cfg: {
       source = create_symlink "${dotfiles}/${cfg.sp}";
       recursive = cfg.r;
       }) configs;
}
