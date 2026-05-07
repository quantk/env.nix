{ pkgs, ... }:

{
  # =========================
  # Packages
  # =========================

  environment.systemPackages = with pkgs; [
    git
    less
    ripgrep
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    zsh-powerlevel10k
    wget
    htop
    btop
    ranger
    kitty
    firefox
    pavucontrol
    networkmanagerapplet
    jq
    nautilus
    geeqie
    gcalcli
    bambu-studio
    tmux
    google-chrome

    # AI Tools
    llm-agents.claude-code
    llm-agents.pi
    llm-agents.codex
    llm-agents.opencode

    godot


    rpi-imager

    # Modern Unix
    ast-grep
    bat
    lsd
    delta
    dust
    duf
    fd
    cheat
    tldr
    gping
    procs
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };
}
