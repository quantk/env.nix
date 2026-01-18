{ pkgs, ... }:

{
  # =========================
  # Home Apps
  # =========================

  home.packages = with pkgs; [
    wofi
    mako
    hyprlock
    playerctl
    bibata-cursors
    neovim
    wl-clipboard
    nil
    nixpkgs-fmt
    jetbrains.idea
    telegram-desktop
    spotify
    gnome-calendar
    codex
    #claude-code
    flameshot
    grim
  ];
}
