{ pkgs, ... }:

{
  # =========================
  # Home Apps
  # =========================

  home.packages = with pkgs; [
    wofi
    wlogout
    mako
    hyprlock
    hyprsunset
    playerctl
    bibata-cursors
    neovim
    wl-clipboard
    nil
    nixpkgs-fmt
    zed-editor
    jetbrains.idea
    telegram-desktop
    spotify
    gnome-calendar
    flameshot
    grim
    thunderbird
    python314
    go
    nodejs
    playwright
    playwright-mcp
    chromium
    obsidian
    libreoffice
    qbittorrent
    zathura
    zathuraPkgs."zathura_pdf_mupdf"
  ];
}
