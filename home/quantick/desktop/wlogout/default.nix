# ==========================================================
# Wlogout — меню выключения (CTRL+ALT+Delete, кнопка ⏻ в баре)
# Блюр — layerrule (namespace logout_dialog) в hyprland.conf
# ==========================================================
{ pkgs, ... }:

let
  icons = "${pkgs.wlogout}/share/wlogout/icons";
in
{
  xdg.configFile."wlogout/layout".source = ./layout;

  # Стиль собирается здесь — нужны пути к иконкам из пакета
  xdg.configFile."wlogout/style.css".text = ''
    * {
      font-family: "Inter";
      background-image: none;
      box-shadow: none;
      transition: all 200ms cubic-bezier(0.2, 1, 0.2, 1);
    }

    window {
      background-color: rgba(15, 14, 26, 0.55);
    }

    button {
      margin: 12px;
      border-radius: 28px;
      border: 1px solid rgba(180, 167, 255, 0.16);
      background-color: rgba(180, 167, 255, 0.07);
      background-repeat: no-repeat;
      background-position: center 42%;
      background-size: 22%;
      color: #a9a4c9;
      font-size: 16px;
      font-weight: 600;
    }

    button:focus,
    button:hover {
      background-color: rgba(180, 167, 255, 0.2);
      border-color: rgba(180, 167, 255, 0.6);
      background-size: 26%;
      color: #ffffff;
    }

    #shutdown:hover, #shutdown:focus {
      background-color: rgba(255, 122, 147, 0.28);
      border-color: rgba(255, 122, 147, 0.7);
    }

    #lock     { background-image: image(url("${icons}/lock.png")); }
    #logout   { background-image: image(url("${icons}/logout.png")); }
    #shutdown { background-image: image(url("${icons}/shutdown.png")); }
    #reboot   { background-image: image(url("${icons}/reboot.png")); }
  '';
}
