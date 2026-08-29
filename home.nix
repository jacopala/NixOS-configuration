{ config, pkgs, ... }:
let
dotfiles = "/home/jacob/NixOS/cfgs";
create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
configs = {
# sp = subpath in ./cfgs
# r  = recursively define
#	use true if needs solid files
#	use false if self-managed
   alacritty 	= { sp = "alacritty";	r = true;  };
   nvim 	= { sp = "nvim";	r = false; };
   quickshell 	= { sp = "quickshell";	r = true;  };
   sway 	= { sp = "sway";	r = true;  };
   swaylock 	= { sp = "swaylock";	r = true;  };
   wofi 	= { sp = "wofi";	r = true;  };
   yazi 	= { sp = "yazi";	r = false; };
};
in
{
# User specific packages
   home.packages = with pkgs; [
## Applications
      alacritty       # Terminal 
         calibre         # E-book manager
         cheese          # Camera
         dragon-drop     # Drag files
         obsidian        # Notes
         quickshell      # Widgets
         swaybg          # Wallpaper
         swaylock        # Sceen locker
         thunar          # GUI file manager (backup)
         vesktop         # Discord alt client
         vlc             # Media player
         wofi            # Menu

## CLI
         ast-grep      # Syntax grep
         bluetui       # Bluetooth TUI
         htop          # Resource monitor
         eza           # Better ls
         fzf           # Fuzzy find
         gh            # GitHub CLI
         leetgo        # LeetCode CLI
         nix-search    # Package repo search
         pfetch        # System info
         ripgrep       # Better grep
         sutils        # Battery & Clock commands
         tree-sitter   # Parser generator
         ueberzugpp    # Images in terminal
         weather       # Forecast
         zoxide        # Better cd

## LAZYGIT
         lazygit
         everforest-cursors

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
         ruby           # Ruby lang
         rustc          # Rust lang

## LIBS
         openssl       # Cryptography for SSL & TLS protocols
         ];

   programs.yazi = {
      enable = true;
      shellWrapperName = "yz";
   };
   programs.neovim = {
      enable = true;
      defaultEditor = true;
      withPython3 = true;
      withRuby = true;
      sideloadInitLua = true;
   };

# Additional init
   home.username = "jacob";
   home.homeDirectory = "/home/jacob";
   programs.git.enable = true;
   home.stateVersion = "25.05";
   programs.bash = {
      enable = true;
      bashrcExtra = ''
         export PS1="\[\e[38;5;4m\]✦ \w\[\e[3m\]\n✨\[\e[0m\]"
         export PATH="$HOME/NixOS/scripts/:$HOME/.cargo/bin:$PATH"  
         '';
      shellAliases = {
         b = "battery";
         c = "clear";
         ls = "eza --icons";
         n = "nvim";
         p = "ping google.com -c 1";
         y = "yazi";
         nmtui='NEWT_COLORS="root=white,black" nmtui';
      };
   };

# Function to assign config files
   xdg.configFile = builtins.mapAttrs 
      (name: cfg: {
       source = create_symlink "${dotfiles}/${cfg.sp}";
       recursive = cfg.r;
       }) configs;
}
