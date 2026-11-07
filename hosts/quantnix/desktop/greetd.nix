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
    "--time" # часы над формой
    "--greeting 'quantnix'"
    "--window-padding 2"
    "--container-padding 2"
    # Цвета в тон палитре «Twilight» (ANSI-имена — tty без truecolor)
    "--theme 'border=magenta;text=gray;prompt=lightmagenta;time=lightblue;action=blue;button=magenta;container=black;input=white;greet=lightmagenta;title=lightmagenta'"
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
