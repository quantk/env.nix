# ==========================================================
# Home Manager — пользователь quantick
#
# desktop/   Hyprland-окружение: hypr, waybar, wofi, mako, …
# terminal/  ghostty, zsh, direnv
# dev/       git, neovim, vscode
# ==========================================================
{ ... }:

{
  imports = [
    ./packages.nix

    # --- Рабочий стол ---
    ./desktop/hypr/default.nix
    ./desktop/waybar/default.nix
    ./desktop/wofi/default.nix
    ./desktop/mako/default.nix
    ./desktop/wlogout/default.nix
    ./desktop/flameshot.nix

    # --- Терминал ---
    ./terminal/ghostty.nix
    ./terminal/zsh.nix
    ./terminal/direnv.nix

    # --- Разработка ---
    ./dev/git.nix
    ./dev/nvim/default.nix
    ./dev/vscode.nix
  ];

  home.username = "quantick";
  home.homeDirectory = "/home/quantick";

  # Как и system.stateVersion — не менять при обновлениях
  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # --- Приложения по умолчанию (xdg-open) ---
  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # PDF
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];

      # Веб
      "text/html" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];

      # Telegram-ссылки
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
      "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];
    };
  };
}
