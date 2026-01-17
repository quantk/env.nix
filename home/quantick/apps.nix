{ config, pkgs, ... }:

{
  # =========================
  # Home Apps
  # =========================

  home.packages = with pkgs; [
    waybar wofi mako hyprlock playerctl
    nerd-fonts.jetbrains-mono noto-fonts-color-emoji
    bibata-cursors
    zsh-powerlevel10k
    neovim wl-clipboard
    nil nixpkgs-fmt
    jetbrains.idea
    telegram-desktop
    ripgrep
    spotify
  ];
}
