{ inputs, pkgs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
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
    wireguard-tools
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
    jdk21
    kubernetes-helm
    zoom-us

    # AI Tools
    llm-agents.opencode

    blender

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
