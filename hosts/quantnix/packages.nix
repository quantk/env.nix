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

    # Modern Unix
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
