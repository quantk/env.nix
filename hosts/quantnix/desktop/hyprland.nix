# ==========================================================
# Hyprland — композитор и компоненты сессии
#
# Здесь только «что установлено». Конфиги (биндинги, бар,
# лаунчер, уведомления) — в home/quantick/desktop/
# ==========================================================
{ pkgs, ... }:

{
  # Ставит Hyprland, регистрирует wayland-сессию,
  # включает xdg-desktop-portal-hyprland
  # (XWayland включён по умолчанию)
  programs.hyprland.enable = true;

  # --- Компоненты сессии ---
  environment.systemPackages = with pkgs; [
    hyprpaper # обои
    hyprlock # экран блокировки
    hyprsunset # ночной режим (тёплые цвета)
    hyprpolkitagent # GUI-запрос пароля для polkit
    waybar # панель
    wofi # лаунчер
    wlogout # меню выключения
    mako # уведомления
  ];

  # --- Переменные Wayland-сессии ---
  # XDG_CURRENT_DESKTOP / XDG_SESSION_TYPE Hyprland выставляет сам,
  # Firefox работает в Wayland по умолчанию
  environment.sessionVariables = {
    # Electron/Chromium — нативно в Wayland (обёртки nixpkgs)
    NIXOS_OZONE_WL = "1";

    # Курсор на NVIDIA: Hyprland сам отключает hw-курсоры
    # (cursor:no_hardware_cursors = 2 по умолчанию), env-переменная не нужна
  };
}
