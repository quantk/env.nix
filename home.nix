{ config, pkgs, ... }:

{
  # Home Manager target for user 'quantick'
  home.username = "quantick";
  home.homeDirectory = "/home/quantick";
  xdg.enable = true;
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    waybar wofi mako hyprlock playerctl           # GUI components
    nerd-fonts.jetbrains-mono noto-fonts-color-emoji   # Fonts (monospace + emoji)
    bibata-cursors                                # Cursor theme
    zsh-powerlevel10k
    neovim wl-clipboard
  ];
  
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Aleksandr Kladov";
        email = "mail@kladov.xyz";
      };

      pull.rebase = true;
      init.defaultBranch = "master";
      core.editor = "nvim";
    };

  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "sudo"
        "docker"
        "kubectl"
	"colored-man-pages"
	"command-not-found"
      ];
    };
    
      initContent = ''
    # p10k instant prompt (ускоряет старт)
    if [[ -r "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      source "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
    fi

    # отключаем авто-обновление OMZ (чтобы не лагало)
    export DISABLE_AUTO_UPDATE="true"
    export ZSH_DISABLE_COMPFIX="true"
    export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD="true"

    # Powerlevel10k
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    [[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh

    # Кэш комплишена (ускоряет)
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/zcompcache"

    setopt HIST_IGNORE_ALL_DUPS
    setopt SHARE_HISTORY
    setopt INC_APPEND_HISTORY
  '';

shellAliases = {
          # nix / nixos
    nr = "sudo nixos-rebuild switch --flake ~/envix#quantnix";
    nu = "nix flake update ~/envix";
    ns = "nix-shell -p";
    nd = "nix develop";
    ngc = "sudo nix-collect-garbage -d";

    # hypr
    hr = "hyprctl reload";
    hm = "hyprctl monitors";
    hb = "hyprctl binds";

    # docker
    d = "docker";
    dc = "docker compose";
    dps = "docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'";
    };
  };
 
  xdg.configFile."/nvim/init.lua".text = ''
    vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 2        -- или 4, как тебе нравится
vim.opt.tabstop = 2
vim.opt.expandtab = true     -- пробелы вместо табов

-- В VISUAL режиме:
-- Tab -> сдвиг вправо
vim.keymap.set("v", "<Tab>", ">gv", { silent = true })

-- Shift+Tab -> сдвиг влево
vim.keymap.set("v", "<S-Tab>", "<gv", { silent = true })
  '';

  # Ensure these packages are available for the user (some are also in systemPackages)
  xdg.configFile."/zsh/.p10k.zsh".text = ''
  # Минималистичный p10k: быстрый, читаемый
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
  typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time)

  typeset -g POWERLEVEL9K_DIR_FOREGROUND=39
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2

  typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0.05
'';

  
  home.file."${config.xdg.configHome}/kitty/kitty.conf".text = ''
    shell_integration enabled    

    font_size 18
    confirm_os_window_close 0
    background_opacity 0.7
  '';

  # Dotfiles and configuration for Hyprland and related apps
  home.file."${config.xdg.configHome}/hypr/hyprland.conf".text = ''
    # Hyprland Configuration for user quantick

    ## General Settings
    beamout-on-switch = yes
    disable_hyprland_logo = yes
    vfr = 60

    # Set $mod to SUPER (Windows/Command key)
    $mod = SUPER

    # Workspaces: use 1-9 on $mod
    #workspace_rules = workspace 1 silent, workspace 2 silent, workspace 3 silent, workspace 4 silent, workspace 5 silent, workspace 6 silent, workspace 7 silent, workspace 8 silent, workspace 9 silent

    bind = $mod, 1, workspace, 1
    bind = $mod, 2, workspace, 2
    bind = $mod, 3, workspace, 3
    bind = $mod, 4, workspace, 4
    bind = $mod, 5, workspace, 5
    bind = $mod, 6, workspace, 6
    bind = $mod, 7, workspace, 7
    bind = $mod, 8, workspace, 8
    bind = $mod, 9, workspace, 9
    bind = $mod, 0, workspace, 10

    bind = $mod SHIFT, 1, movetoworkspace, 1
    bind = $mod SHIFT, 2, movetoworkspace, 2
    bind = $mod SHIFT, 3, movetoworkspace, 3
    bind = $mod SHIFT, 4, movetoworkspace, 4
    bind = $mod SHIFT, 5, movetoworkspace, 5
    bind = $mod SHIFT, 6, movetoworkspace, 6
    bind = $mod SHIFT, 7, movetoworkspace, 7
    bind = $mod SHIFT, 8, movetoworkspace, 8
    bind = $mod SHIFT, 9, movetoworkspace, 9
    bind = $mod SHIFT, 0, movetoworkspace, 10

    bind = $mod, H, movefocus, l
    bind = $mod, J, movefocus, d
    bind = $mod, K, movefocus, u
    bind = $mod, L, movefocus, r

    ## Key Bindings
    bind = $mod, Return, exec, kitty                        # Open Kitty terminal
    bind = $mod, A, exec, wofi --show drun                  # Application launcher (Wofi)
    bind = $mod, Q, killactive                              # Close focused window
    bind = $mod|Shift, Q, exec, hyprctl dispatch exit        # Quit Hyprland session
    bind = $mod SHIFT, L, exec, hyprlock                          # Lock the screen (Hyprlock):contentReference[oaicite:26]{index=26}
    # (Add more keybinds as desired, e.g., volume keys via pamixer, etc.)

    ## Autostart Applications
    exec-once = waybar                                      # Start Waybar panel at login:contentReference[oaicite:27]{index=27}:contentReference[oaicite:28]{index=28}
    exec-once = mako                                        # Start Mako notification daemon:contentReference[oaicite:29]{index=29}
    exec-once = ${pkgs.hyprpolkitagent}/bin/hyprpolkitagent  # Start Hyprland polkit agent for GUI sudo

    general {
      border_size = 2
    }

    monitor = DP-5,2560x1440@165.00,0x0,1 
    input {
      follow_mouse = yes
      kb_layout = us,ru
      kb_options = grp:caps_toggle,grp_led:caps
    }
  '';

  home.file."${config.xdg.configHome}/waybar/config.jsonc".text = ''
{
  "layer": "top",
  "position": "top",
  "height": 34,
  "spacing": 8,

  "modules-left": [],
  "modules-center": [
    "hyprland/workspaces",
    "clock"
  ],
  "modules-right": [],

  "hyprland/workspaces": {
    "format": "{name}",
    "on-click": "hyprctl dispatch workspace {name}",
    "disable-scroll": true
  },

  "clock": {
    "format": "{:%H:%M}",
    "tooltip": false
  }
}
 
  '';

  home.file."${config.xdg.configHome}/waybar/style.css".text = ''
  * {
  font-family: JetBrainsMono Nerd Font;
  font-size: 13px;
}

window#waybar {
  background: rgba(20, 20, 20, 0.85);
  color: #e5e5e5;
}

#workspaces button {
  padding: 0 8px;
  margin: 0 2px;
  border-radius: 6px;
  background: transparent;
  color: #888888;
}

#workspaces button.active {
  background: #3b82f6;
  color: #ffffff;
}

#workspaces button:hover {
  background: rgba(255, 255, 255, 0.1);
}

#clock {
  margin-left: 12px;
  padding: 0 8px;
  font-weight: 600;
}
'';

  home.file."${config.xdg.configHome}/wofi/config".text = ''
    # Wofi configuration (application launcher)
    # Wofi in "drun" mode (application menu)
    show = drun
    # Appearance settings
    width = 40%
    height = 30%
    columns = 1
    hide_scroll = true
    prompt = Launch:
    # Use the custom style.css
    style = ${config.xdg.configHome}/wofi/style.css
    gtk_dark = true
  '';

  home.file."${config.xdg.configHome}/wofi/style.css".text = ''
    /* Wofi CSS for appearance */
    * {
      font-family: "JetBrainsMono Nerd Font Mono";
      font-size: 12px;
    }
    window {
      background: rgba(30, 30, 30, 0.95);
      color: #ffffff;
    }
    header {
      background: rgba(30, 30, 30, 0.0);
      border-bottom: 2px solid #555555;
    }
    #entry {
      padding: 4px 8px;
      margin: 4px 0;
      border: 2px solid #888888;
      background: rgba(0, 0, 0, 0.0);
      color: #dddddd;
    }
    #entry:focus {
      border-color: #88b4f0;
    }
    #list {
      padding: 4px 0;
    }
    #list element {
      padding: 4px 8px;
    }
    #list element:selected {
      background: #555555;
      color: #ffffff;
    }
  '';

  home.file."${config.xdg.configHome}/mako/config".text = ''
    # Mako (Wayland notification daemon) configuration
    font=JetBrainsMono Nerd Font Mono 12
    background-color=#282828
    text-color=#FFFFFF
    border-color=#888888
    border-size=2
    padding=8
    default-timeout=5000
    # position (top-right by default); for example:
    anchor=top-right
    # max notifications displayed at once:
    max-visible=5
  '';

  home.file."${config.xdg.configHome}/hypr/hyprlock.conf".text = ''
    # Hyprlock configuration (screen locker)
    # A config is required for hyprlock to display the lock screen UI:contentReference[oaicite:30]{index=30}.
    general {
      # Grace period before requiring password after locking (seconds)
      grace = 1
      immediate_render = false   # Wait for resources before drawing (use black screen until ready)
    }
    background {
      monitor =                # apply to all monitors
      # No image; just a solid color background
      color = 0x1e1e1e          # dark gray background
      blur = false
    }
    input-field {
      monitor =
      size = 300,50
      outline_thickness = 2
      outer_color = rgba(255,255,255,0.2)    # border color (semi-transparent white)
      inner_color = rgba(0,0,0,0.6)          # box fill color (semi-transparent black)
      font_color = rgba(255,255,255,1.0)     # text color (white)
      placeholder_text = <i>Enter password...</i>
      hide_input = false                    # show placeholder and typed dots
      halign = center
      valign = center
    }
  '';
}

