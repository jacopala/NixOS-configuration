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
   mako        = { sp = "mako";	r = true;  };
   niri        = { sp = "niri"; r = true; };
   nvim 	      = { sp = "nvim";	r = false; };
   quickshell 	= { sp = "quickshell";	r = true;  };
   sway 	      = { sp = "sway";	r = true;  };
   yazi 	      = { sp = "yazi";	r = false; };
};
in
{
# User specific packages
   home.packages = with pkgs; [
## Applications
      claude-code
      code-cursor     # Code editor
      floorp-bin      # Firefox fork
      fuzzel          # Launcher
      gimp            # Image editing
      kitty           # Terminal
      obsidian        # Notes
      olympus         # Celeste mod loader
      osu-lazer-bin   # Osu
      #plover_5        # Stenography
      prismlauncher   # Minecraft
      quickshell      # Widgets
      swaybg          # Wallpaper
      swaylock        # Sceen locker
      trayscale       # Tailscale GUI wrapper
      vesktop         # Discord alt client

## Media
      cheese          # Camera
      kdePackages.dolphin   # GUI file manager
      vlc             # Video/Audio player

## CLI
      ast-grep    # Syntax grep
      bluetui     # Bluetooth TUI
      calc        # Quick calc
      dragon-drop # Drag files
      htop        # Memory/process monitor
      gcalcli     # Google Calendar in CLI
      feh         # Simple image viewer
      fzf         # Fuzzy find
      gh          # GitHub CLI
      leetgo      # LeetCode CLI
      nix-search  # Package repo search
      nerdfetch   # System info
      powertop    # Battery monitor
      sutils      # Battery & Clock commands
      tree-sitter # Parser generator
      ueberzugpp  # Images in terminal
      weather     # Forecast
      yt-dlp-light# Youtube video downloading

      bat         # Better cat
      eza         # Better ls
      ripgrep     # Better grep
      tldr        # Better man
      zoxide      # Better cd


## SECURITY
      gobuster    # Brute-force tool
      metasploit  # Exploit collection
      nmap        # Network discovery
      openvpn     # Tunneling
      wireshark   # Network protocol analyzer

## temp
      lazygit
      mars-mips

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
      uv
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
