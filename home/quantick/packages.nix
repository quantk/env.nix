# ==========================================================
# Пользовательские приложения
#
# Компоненты Hyprland-сессии (waybar, wofi, mako, hyprlock…)
# ставятся системно — hosts/quantnix/desktop/hyprland.nix
# ==========================================================
{ pkgs, ... }:

{
  # programs.codexDesktopLinux.enable = true;

  home.packages = with pkgs; [
    # --- Wayland-утилиты ---
    wl-clipboard # wl-copy / wl-paste
    flameshot

    # --- Редакторы / IDE ---
    neovim
    zed-editor
    jetbrains.idea

    # --- Nix ---
    nil # LSP
    nixpkgs-fmt # форматтер

    # --- Языки и тулчейны ---
    go
    gopls
    python314
    uv # пакетный менеджер Python
    nodejs
    maven
    tree-sitter
    stylua # форматтер Lua (для nvim-конфига)

    # --- Dev-инструменты ---
    dbeaver-bin
    postman
    gh # GitHub CLI
    playwright
    playwright-mcp
    chromium # браузер для playwright

    # --- Связь ---
    telegram-desktop
    thunderbird

    # --- Документы / заметки ---
    obsidian
    libreoffice
    gnome-calendar
    zathura
    zathuraPkgs.zathura_pdf_mupdf

    # --- Медиа ---
    spotify
    yt-dlp

    # --- Сеть ---
    qbittorrent
  ];
}
