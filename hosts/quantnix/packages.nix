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
    tmux
    google-chrome
    rustc
    cargo
    gcc
    bubblewrap
    ansible

    # AI Tools
    llm-agents.claude-code
    llm-agents.pi
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
