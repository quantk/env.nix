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
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # для X11-приложений
  };

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
    xdg-desktop-portal
  ];

  # --- Переменные Wayland-сессии ---
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_CURRENT_DESKTOP = "Hyprland";

    # Electron/Chromium/Firefox — нативно в Wayland
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    MOZ_ENABLE_WAYLAND = "1";

    # Курсор на NVIDIA: Hyprland сам отключает hw-курсоры
    # (cursor:no_hardware_cursors = 2 по умолчанию), env-переменная не нужна
  };
}
