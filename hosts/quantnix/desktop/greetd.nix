# ==========================================================
# Логин — greetd + tuigreet (текстовый экран входа на tty1)
# ==========================================================
{ config, pkgs, ... }:

let
  sessions = config.services.displayManager.sessionData.desktops;

  tuigreet = builtins.concatStringsSep " " [
    "${pkgs.tuigreet}/bin/tuigreet"
    "--remember" # помнить последнего пользователя
    "--remember-user-session" # …и его сессию
    "--user-menu"
    "--user-menu-min-uid 1000"
    "--asterisks" # звёздочки при вводе пароля
    "--sessions ${sessions}/share/wayland-sessions"
    "--xsessions ${sessions}/share/xsessions"
    "--power-shutdown 'shutdown -P now'"
    "--power-reboot 'shutdown -r now'"
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
