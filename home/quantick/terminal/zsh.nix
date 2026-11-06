# ==========================================================
# Zsh — oh-my-zsh + Powerlevel10k, алиасы
# ==========================================================
{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true; # серые подсказки из истории
    syntaxHighlighting.enable = true;

    # --- oh-my-zsh ---
    oh-my-zsh = {
      enable = true;
      theme = ""; # тема — Powerlevel10k (initContent)
      plugins = [
        "git"
        "sudo" # Esc Esc — добавить sudo к команде
        "docker"
        "kubectl"
        "colored-man-pages"
        "command-not-found"
      ];
    };

    initContent = lib.mkMerge [
      # До oh-my-zsh: instant prompt и переменные, которые он читает при загрузке
      (lib.mkBefore ''
        # --- Powerlevel10k: instant prompt (должен идти первым) ---
        if [[ -r "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi

        # oh-my-zsh лежит в read-only Nix store: не проверять права
        export ZSH_DISABLE_COMPFIX="true"
        export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD="true"
      '')

      ''
        # --- Powerlevel10k: тема + конфиг (см. .p10k.zsh ниже) ---
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh

        # --- Кэш автодополнения ---
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/zcompcache"

        # --- История: без дублей, общая между терминалами ---
        setopt HIST_IGNORE_ALL_DUPS
        setopt SHARE_HISTORY
        setopt INC_APPEND_HISTORY

        # --- PATH: бинарники вне Nix (pnpm, npm -g, pip --user) ---
        export PNPM_HOME="/home/quantick/.local/share/pnpm"
        case ":$PATH:" in
          *":$PNPM_HOME:"*) ;;
          *) export PATH="$PNPM_HOME:$PATH" ;;
        esac

        export PATH="$HOME/.local/bin:$PATH"
        export PATH="$HOME/.npm-global/bin:$PATH"

        # --- Прочее ---
        export OPENCODE_DISABLE_MODELS_FETCH=1
      ''
    ];

    shellAliases = {
      # --- Modern Unix ---
      vim = "nvim";
      ls = "lsd";
      df = "duf";
      du = "dust";

      # --- Nix / NixOS ---
      nr = "sudo nixos-rebuild switch --flake ~/envix#quantnix"; # применить конфиг
      nu = "nix flake update ~/envix"; # обновить flake.lock
      ns = "nix-shell -p"; # временный пакет
      nd = "nix develop";
      ngc = "sudo nix-collect-garbage -d"; # удалить старые поколения

      # --- Hyprland ---
      hr = "hyprctl reload";
      hm = "hyprctl monitors";
      hb = "hyprctl binds";

      # --- Docker ---
      d = "docker";
      dc = "docker compose";
      dps = "docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'";
    };
  };

  # --- Конфиг Powerlevel10k ---
  xdg.configFile."zsh/.p10k.zsh".text = ''
    # Двухстрочный промпт, без пустой строки между командами
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
    typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

    # Слева: ОС, каталог, git. Справа: код возврата, время выполнения, часы
    typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time)

    typeset -g POWERLEVEL9K_DIR_FOREGROUND=39
    typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2 # показывать, если > 2 c

    typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0.05
  '';
}
