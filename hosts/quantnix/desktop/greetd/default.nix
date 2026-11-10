# ==========================================================
# Логин — greetd + ReGreet (графический экран входа)
#
# Композитор — отдельный минимальный Hyprland (hyprland.conf),
# вид — regreet.css в палитре «Twilight», как hyprlock.
# Фон собирается при сборке: обои → блюр, притемнение, виньетка.
# ==========================================================
{ config, lib, pkgs, ... }:

let
  hyprland = config.programs.hyprland.package;

  # Размытые обои — тот же приём, что у hyprlock, но заранее:
  # GTK не умеет blur, поэтому «печём» картинку ImageMagick'ом
  background = pkgs.runCommand "greeter-background.jpg"
    { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
    magick ${./wallpaper.jpg} \
      -resize 2560x1440^ -gravity center -extent 2560x1440 \
      -blur 0x22 -modulate 72,120 \
      \( -size 2560x1440 radial-gradient:'rgba(15,14,26,0)-rgba(10,8,24,0.85)' \) \
      -compose over -composite \
      -attenuate 0.25 +noise Gaussian \
      -quality 92 $out
  '';

  hyprConf = pkgs.writeText "greeter-hyprland.conf" ''
    ${builtins.readFile ./hyprland.conf}

    # ReGreet; после входа — закрыть композитор greeter'а
    exec-once = ${lib.getExe config.services.displayManager.regreet.package}; ${hyprland}/bin/hyprctl dispatch exit
  '';
in
{
  services.displayManager.regreet = {
    enable = true;

    theme.name = "Adwaita"; # база GTK4; всё остальное перекрывает CSS
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 13;
    };

    settings = {
      background = {
        path = "${background}";
        fit = "Cover";
      };

      GTK.application_prefer_dark_theme = true;

      commands = {
        reboot = [ "systemctl" "reboot" ];
        poweroff = [ "systemctl" "poweroff" ];
      };

      appearance.greeting_msg = "Welcome back";

      # Часы как в hyprlock: крупное время + дата лавандой (Pango-разметка)
      widget.clock = {
        format = builtins.concatStringsSep "\n" [
          "<span font_weight='800' size='112pt' foreground='#e6e3f5'>%H:%M</span>"
          "<span font_weight='500' size='22pt' foreground='#b4a7ff'>%A, %-d %B</span>"
        ];
        resolution = "1s";
        label_width = 700;
        locale = "en_US";
      };
    };

    extraCss = ./regreet.css;
  };

  # Вместо cage — свой Hyprland (модуль regreet ставит cage через mkDefault)
  services.greetd = {
    settings = {
      default_session.command = "${pkgs.dbus}/bin/dbus-run-session ${hyprland}/bin/start-hyprland -- --config ${hyprConf}";
      terminal.vt = 1;
    };
  };
}
