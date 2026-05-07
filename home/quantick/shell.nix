{ config, pkgs, ... }:

{
  # =========================
  # Shell
  # =========================

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
      # p10k instant prompt
      if [[ -r "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # disable omz auto update
      export DISABLE_AUTO_UPDATE="true"
      export ZSH_DISABLE_COMPFIX="true"
      export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD="true"

      # Powerlevel10k
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh

      # completion cache 
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/zcompcache"

      setopt HIST_IGNORE_ALL_DUPS
      setopt SHARE_HISTORY
      setopt INC_APPEND_HISTORY

      export PNPM_HOME="/home/quantick/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac

      export PATH="$HOME/.local/bin:$PATH"
      export PATH="$HOME/.npm-global/bin:$PATH"

      export OPENCODE_DISABLE_MODELS_FETCH=1
    '';

    shellAliases = {
      # user
      vim = "nvim";
      ls  = "lsd";
      df  = "duf";
      du  = "dust";

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

  xdg.configFile."/zsh/.p10k.zsh".text = ''
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
}
