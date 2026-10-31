{ pkgs, ... }:

{
  # programs.codexDesktopLinux.enable = true;

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
    gopls
    nodejs
    playwright
    playwright-mcp
    chromium
    obsidian
    libreoffice
    qbittorrent
    zathura
    zathuraPkgs."zathura_pdf_mupdf"
    tree-sitter
    stylua
    gcc
    herdr
    gh
    yt-dlp
    uv
    sing-box
  ];
}
