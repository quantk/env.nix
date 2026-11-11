# ==========================================================
# Логин — greetd + tuigreet (текстовый экран входа на tty1)
#
# Сразу логин → пароль → Hyprland. Без отдельного композитора
# под greeter: нечему падать при передаче экрана (NVIDIA).
# ==========================================================
{ config, pkgs, ... }:

let
  hyprland = config.programs.hyprland.package;
  sessions = config.services.displayManager.sessionData.desktops;

  tuigreet = builtins.concatStringsSep " " [
    "${pkgs.tuigreet}/bin/tuigreet"
    "--time" # часы
    "--remember" # подставить последнего пользователя → сразу пароль
    "--asterisks" # звёздочки при вводе пароля
    "--cmd ${hyprland}/bin/start-hyprland" # сессия по умолчанию
    "--sessions ${sessions}/share/wayland-sessions" # F3 — выбор сессии
    "--power-shutdown 'systemctl poweroff'"
    "--power-reboot 'systemctl reboot'"
  ];
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = tuigreet;
        user = "greeter";
      };
      terminal.vt = 1;
    };
  };
}
