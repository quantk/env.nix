# ==========================================================
# Hyprland — композитор и компоненты сессии
#
# Здесь только «что установлено». Конфиги (биндинги, бар,
# лаунчер, уведомления) — в home/quantick/desktop/
# ==========================================================
{ config, lib, pkgs, ... }:

let
  hyprland = config.programs.hyprland.package;

  # Пакет Hyprland кладёт две сессии: hyprland.desktop и hyprland-uwsm.desktop.
  # UWSM не используем (withUWSM = false, юнитов uwsm нет) — uwsm-сессия
  # в greeter'е сразу падает. Оставляем только обычную.
  hyprlandSession = pkgs.runCommand "hyprland-session"
    { passthru.providedSessions = [ "hyprland" ]; } ''
    install -Dm644 ${hyprland}/share/wayland-sessions/hyprland.desktop \
      $out/share/wayland-sessions/hyprland.desktop
  '';
in
{
  # Ставит Hyprland, включает xdg-desktop-portal-hyprland
  # (XWayland включён по умолчанию)
  programs.hyprland.enable = true;

  # Сессии для greeter'а — только Hyprland без uwsm (см. выше)
  services.displayManager.sessionPackages = lib.mkForce [ hyprlandSession ];

  # --- Компоненты сессии ---
  environment.systemPackages = with pkgs; [
    hyprpaper # обои (запасные, статичные)
    linux-wallpaperengine # живые обои из Wallpaper Engine
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
