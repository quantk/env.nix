# ==========================================================
# Шрифты и курсор
# ==========================================================
{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono # моноширинный + иконки (waybar, nvim)
    inter # UI-шрифт: панель, лаунчер, уведомления, экран блокировки
    noto-fonts-color-emoji
  ];

  # --- Курсор ---
  environment.systemPackages = [ pkgs.bibata-cursors ];
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}
